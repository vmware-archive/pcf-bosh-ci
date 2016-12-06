#!/usr/bin/env bash

source pcf-bosh-ci/scripts/load-director-environment.sh bosh-creds/bosh-creds.yml

bosh -n deploy cf-deployment/cf-deployment.yml \
  --deployment cf \
  --ops-file cf-deployment/opsfiles/gcp.yml \
  --var system_domain=ol-smokey.gcp.pcf-bosh.cf-app.com