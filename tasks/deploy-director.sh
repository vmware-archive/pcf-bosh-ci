#!/usr/bin/env bash

set -e

cat <<BOSHVARS > bosh-vars.yml
---
director_name: pcf-bosh-director
internal_cidr: $(jq -r .cf_cidr terraform-state/metadata)
internal_gw: $(jq -r .cf_gateway terraform-state/metadata)
internal_ip: $(jq -r .cf_director_internal_ip terraform-state/metadata)
network: $(jq -r .network_name terraform-state/metadata)
project_id: $(jq -r .project terraform-state/metadata)
subnetwork: $(jq -r .cf_subnet terraform-state/metadata)
zone: $(jq -r .azs[0] terraform-state/metadata)
bosh_director_tags: $(jq -r .bosh_director_tags terraform-state/metadata)
bosh_director_domain: $(jq -r .bosh_director_domain terraform-state/metadata)
gcp_credentials_json: |
    $(echo $GOOGLE_JSON_KEY)
credhub_aes_key: 547378EB7909D6078C14FCBE631D3BAF
file_path_to_credhub_release: "file://$PWD/credhub-release/credhub-0.3.0.tgz"
BOSHVARS

cp "bosh-state/\"${ENV_NAME}\"-bosh-state.json" new-bosh-state/bosh-state.json
cp "bosh-creds/\"${ENV_NAME}\"-bosh-creds.yml" new-bosh-creds/bosh-creds.yml

bosh create-env bosh-deployment/bosh.yml \
  --state new-bosh-state/bosh-state.json \
  --ops-file bosh-deployment/external-ip-not-recommended.yml \
  --ops-file bosh-deployment/gcp/cpi.yml \
  --ops-file bosh-deployment/uaa.yml \
  --ops-file pcf-bosh-ci/ops-files/uaa-with-external-ip.yml \
  --ops-file pcf-bosh-ci/ops-files/credhub.yml \
  --ops-file pcf-bosh-ci/ops-files/director-overrides.yml \
  --vars-store new-bosh-creds/bosh-creds.yml \
  --vars-file bosh-vars.yml
