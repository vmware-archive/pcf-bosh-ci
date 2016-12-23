#!/bin/bash

set -e

creds_json=$(pcf-bosh-ci/scripts/yaml2json cf-creds/*-cf-creds.yml)

cf_username="admin"
cf_password=$(echo "$creds_json" | jq -r .uaa_scim_users_admin_password)
cf_target="https://api.$(jq -r .sys_domain terraform-state/metadata)"

cf api "$cf_target" --skip-ssl-validation

cf auth "$cf_username" "$cf_password"

cf enable-feature-flag diego_docker
