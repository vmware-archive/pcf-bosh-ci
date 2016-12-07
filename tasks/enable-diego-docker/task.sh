#!/bin/bash

set -e

creds_json=$(ruby -ryaml -rjson -e "puts JSON.pretty_generate(YAML.load_file('cf-creds/cf-creds.yml'))")

cf_username="admin"
cf_password=$(echo "$creds_json" | jq -r .uaa_scim_users_admin_password)
cf_target="https://api.sys.ol-smokey.gcp.pcf-bosh.cf-app.com"

cf login -a "$cf_target" -u "$cf_username" -p "$cf_target" --skip-ssl-validation

cf enable-feature-flag diego_docker
