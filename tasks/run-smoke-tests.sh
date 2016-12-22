#!/usr/bin/env bash

source pcf-bosh-ci/scripts/load-director-environment.sh bosh-creds/bosh-creds.yml terraform-state/metadata

bosh -n -d cf run-errand smoke-tests