#!/usr/bin/env bash

set -e

cat <<BOSHVARS > bosh-vars.yml
---
director_name: pcf-bosh-director
az: $(jq -r .azs[0] terraform-state/metadata)
subnet_id: $(jq -r .management_subnet_ids[0] terraform-state/metadata)
internal_cidr: $(jq -r .management_subnet_cidrs[0] terraform-state/metadata)
internal_gw: $(jq -r .management_subnet_gateways[0] terraform-state/metadata)
internal_ip: $(jq -r .bosh_director_ips_on_management_subnets[0] terraform-state/metadata)
external_ip: $(jq -r .bosh_director_external_ip terraform-state/metadata)
access_key_id: $(jq -r .iam_user_access_key terraform-state/metadata)
secret_access_key: $(jq -r .iam_user_secret_access_key terraform-state/metadata)
default_key_name: $(jq -r .default_key_name terraform-state/metadata)
default_security_groups: [$(jq -r .vms_security_group_id terraform-state/metadata)]
region: $(jq -r .region terraform-state/metadata)
BOSHVARS

cp bosh-state/*-bosh-state.json new-bosh-state/bosh-state.json
cp bosh-vars-store/*-bosh-vars-store.yml new-bosh-vars-store/bosh-vars-store.yml

bosh create-env bosh-deployment/bosh.yml \
  --state new-bosh-state/bosh-state.json \
  --ops-file bosh-deployment/external-ip-not-recommended.yml \
  --ops-file bosh-deployment/aws/cpi.yml \
  --ops-file bosh-deployment/uaa.yml \
  --ops-file pcf-bosh-ci/ops-files/uaa-with-external-domain.yml \
  --ops-file pcf-bosh-ci/ops-files/director-overrides.yml \
  --vars-store new-bosh-vars-store/bosh-vars-store.yml \
  --vars-file bosh-vars.yml \
  --var-file private_key=bosh-private-key/bosh-private-key

