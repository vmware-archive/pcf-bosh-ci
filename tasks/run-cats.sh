#!/usr/bin/env bash

set -e

cf_creds_json=$(ruby -ryaml -rjson -e "puts JSON.pretty_generate(YAML.load_file('cf-creds/cf-creds.yml'))")

cat <<CFCATSCONFIG > cf-cats-config.json
{
  "addresses": ["$(jq -r .tcp_domain terraform-state/metadata)"],
  "api": "api.$(jq -r .sys_domain terraform-state/metadata)",
  "admin_user": "admin",
  "admin_password": "$(echo "$cf_creds_json" | jq -r .uaa_scim_users_admin_password)",
  "skip_ssl_validation": true,
  "use_http":true,
  "apps_domain": "$(jq -r .apps_domain terraform-state/metadata)",
  "include_http_routes": true,
  "oauth": {
    "token_endpoint": "https://uaa.$(jq -r .sys_domain terraform-state/metadata)",
    "client_name": "tcp_emitter",
    "client_secret": "$(echo "$cf_creds_json" | jq -r .uaa_clients_tcp_emitter_secret)",
    "port": 443,
    "skip_ssl_validation": true
  }
}
CFCATSCONFIG

export CONFIG="$PWD/cf-cats-config.json"

export CF_GOPATH="/go/src/github.com/cloudfoundry/"

echo "Moving cf-acceptance-tests onto the gopath..."
mkdir -p $CF_GOPATH
cp -R cf-acceptance-tests $CF_GOPATH

cd /go/src/github.com/cloudfoundry/cf-acceptance-tests

./bin/test \
-keepGoing \
-randomizeAllSpecs \
-skipPackage=helpers \
-slowSpecThreshold=120 \
-nodes=6