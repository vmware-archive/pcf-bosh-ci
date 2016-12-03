#!/usr/bin/env bash

creds_path="$1"
creds_json=$(ruby -ryaml -rjson -e "puts JSON.pretty_generate(YAML.load_file('$creds_path'))")

export BOSH_USER="admin"
export BOSH_PASSWORD=$(echo "$creds_json" | jq -r .admin_password)
export BOSH_ENVIRONMENT="director.ol-smokey.gcp.pcf-bosh.cf-app.com"
export BOSH_CA_CERT=$(echo "$creds_json" | jq -r .director_ssl.ca)
