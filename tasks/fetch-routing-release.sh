#!/usr/bin/env bash

set -e

cf_deployment_json=$(ruby -ryaml -rjson -e "puts JSON.pretty_generate(YAML.load_file('cf-deployment/cf-deployment.yml'))")

routing_release_version=$(echo "$cf_deployment_json" | jq ".releases[] | select(.name == \"routing\").version" -r)

git clone \
    https://github.com/cloudfoundry-incubator/routing-release/ \
    routing-release \
    --branch "$routing_release_version" \
    --recursive
