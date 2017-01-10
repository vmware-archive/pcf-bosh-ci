#!/usr/bin/env bash

set -e

eval "$(pcf-bosh-ci/scripts/director-environment bosh-vars-store/*-bosh-vars-store.yml terraform-state/metadata)"

cp mysql-vars-store/*-mysql-vars-store.yml new-mysql-vars-store/mysql-vars-store.yml

bosh -n deploy cf-mysql-release-repo/manifest-generation/cf-mysql-template-v2.yml \
  --deployment cf-mysql \
  --ops-file pcf-bosh-ci/ops-files/cf-mysql-overrides.yml \
  --vars-store new-mysql-vars-store/mysql-vars-store.yml
