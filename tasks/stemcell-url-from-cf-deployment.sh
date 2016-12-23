#!/usr/bin/env bash

set -e

manifest=$(pcf-bosh-ci/scripts/yaml2json cf-deployment/cf-deployment.yml)

stemcell_version=$(echo "$manifest" | jq -r .stemcells[0].version)

curl "bosh.io/api/v1/stemcells/$NAME?all=1" | \
jq -r ".[] | select(.version == \"$stemcell_version\") | .light.url" \
> stemcell-url/stemcell-url
