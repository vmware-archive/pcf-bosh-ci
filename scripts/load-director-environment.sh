#!/usr/bin/env bash

creds_path="$1"
terraform_state_path="$2"

creds_json=$(ruby -ryaml -rjson -e "puts JSON.pretty_generate(YAML.load_file('$creds_path'))")

export BOSH_USER="admin"
export BOSH_PASSWORD=$(echo "$creds_json" | jq -r .admin_password)
export BOSH_ENVIRONMENT=$(jq -r .director_external_ip "$terraform_state_path")
export BOSH_CA_CERT=$(echo "$creds_json" | jq -r .director_ssl.ca)
