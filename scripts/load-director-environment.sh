#!/usr/bin/env bash

creds_path="$1"
terraform_state_path="$2"

creds_json=$(ruby -ryaml -rjson -e "puts JSON.pretty_generate(YAML.load_file('$creds_path'))")

export BOSH_CLIENT="ci"
export BOSH_CLIENT_SECRET
BOSH_CLIENT_SECRET=$(echo "$creds_json" | jq -r .ci_secret)

export BOSH_ENVIRONMENT="$(jq -r .bosh_director_domain terraform-state/metadata)"
export BOSH_CA_CERT
BOSH_CA_CERT=$(echo "$creds_json" | jq -r .director_ssl.ca)
