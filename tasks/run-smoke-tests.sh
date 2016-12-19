#!/usr/bin/env bash

source pcf-bosh-ci/scripts/load-director-environment.sh bosh-creds/bosh-creds.yml

bosh -n -d cf run-errand smoke-tests