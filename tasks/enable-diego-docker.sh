#!/bin/bash

set -e

cf_username="admin"
cf_password=$(bosh int cf-vars-store/*-cf-vars-store.yml --path /uaa_scim_users_admin_password)
cf_target="https://api.$(jq -r .sys_domain terraform-state/metadata)"

cf api "$cf_target" --skip-ssl-validation

cf auth "$cf_username" "$cf_password"

cf enable-feature-flag diego_docker
