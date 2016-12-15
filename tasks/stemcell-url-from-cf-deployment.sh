#!/usr/bin/env bash

set -e

manifest="$(ruby -ryaml -rjson -e "puts JSON.pretty_generate(YAML.load_file('cf-deployment/cf-deployment.yml'))")"

stemcell_version=$(echo "$manifest" | jq -r .stemcells[0].version)

curl "bosh.io/api/v1/stemcells/$NAME?all=1" | \
jq -r ".[] | select(.version == \"$stemcell_version\") | .light.url" \
> stemcell-url/stemcell-url
