#!/usr/bin/env bash

bosh create-env bosh-deployment/bosh.yml \
  --state bosh-state/bosh-state.json \
  --ops-file bosh-deployment/gcp/cpi.yml \
  --ops-file bosh-deployment/uaa.yml \
  --vars-store bosh-creds/bosh-creds.yml \
  --vars-file bosh-vars/bosh-vars.yml
#  --ops-file credhub/credhub.yml \
