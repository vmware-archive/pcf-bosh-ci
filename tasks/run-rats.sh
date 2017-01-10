#!/usr/bin/env bash

set -e

cf_creds_json=$(pcf-bosh-ci/scripts/yaml2json cf-vars-store/*-cf-vars-store.yml)

cat <<CFRATSCONFIG > cf-rats-config.json
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
CFRATSCONFIG

export CONFIG="$PWD/cf-rats-config.json"
export GOPATH="$PWD/routing-release"
export PATH="${GOPATH}/bin":$PATH

cd "$GOPATH/src/code.cloudfoundry.org/routing-acceptance-tests/"

bin/test
