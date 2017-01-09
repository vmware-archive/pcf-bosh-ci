#!/usr/bin/env bash

set -e

eval "$(pcf-bosh-ci/scripts/director-environment bosh-creds/*-bosh-creds.yml terraform-state/metadata)"

cp mysql-creds/*-mysql-creds.yml new-mysql-creds/mysql-creds.yml

bosh -n deploy cf-mysql-release-repo/manifest-generation/cf-mysql-template-v2.yml \
  --deployment mysql \
  --ops-file pcf-bosh-ci/ops-files/cf-mysql-overrides.yml \
  --vars-store new-mysql-creds/mysql-creds.yml
