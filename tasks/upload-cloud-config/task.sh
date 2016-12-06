#!/usr/bin/env bash

source pcf-bosh-ci/scripts/load-director-environment.sh bosh-creds/bosh-creds.yml

bosh -n update-cloud-config pcf-bosh-ci/cloud-config.yml