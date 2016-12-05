#!/usr/bin/env bash

set -e

bosh create-env bosh-deployment/bosh.yml \
  --state bosh-state/bosh-state.json \
  --ops-file pcf-bosh-ci/ops-files/ljfranklin_external-ip-not-recommended.yml \
  --ops-file bosh-deployment/gcp/cpi.yml \
  --ops-file bosh-deployment/uaa.yml \
  --ops-file pcf-bosh-ci/ops-files/uaa-with-external-ip.yml \
  --ops-file pcf-bosh-ci/ops-files/credhub.yml \
  --ops-file pcf-bosh-ci/ops-files/director-overrides.yml \
  --vars-store bosh-creds/bosh-creds.yml \
  --vars-file bosh-vars/bosh-vars.yml \
  --var file_path_to_credhub_release="file://$PWD/credhub-release/credhub-0.3.0.tgz" \
  --var external_ip="$(jq -r .director_external_ip terraform-state/metadata)"

cp bosh-state/bosh-state.json new-bosh-state/bosh-state.json