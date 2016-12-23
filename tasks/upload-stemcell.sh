#!/usr/bin/env bash

set -e

eval "$(pcf-bosh-ci/scripts/director-environment bosh-creds/*-bosh-creds.yml terraform-state/metadata)"

bosh -n upload-stemcell "$(cat stemcell-url/stemcell-url)"