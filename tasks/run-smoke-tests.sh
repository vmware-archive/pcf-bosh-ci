#!/usr/bin/env bash

source pcf-bosh-ci/scripts/load-director-environment.sh bosh-creds/bosh-creds.yml

bosh -n run-errand smoke-tests