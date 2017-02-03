#!/usr/bin/env bash

set -e

cat <<TERRAFORM_DB_VARS > terraform-db-vars/terraform.tfvars.yml
---
rds_endpoint: $(jq -r .rds_endpoint terraform-state/metadata)
rds_username: $(jq -r .rds_username terraform-state/metadata)
rds_password: $(jq -r .rds_password terraform-state/metadata)
TERRAFORM_DB_VARS
