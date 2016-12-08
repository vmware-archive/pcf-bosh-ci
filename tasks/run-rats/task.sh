#!/usr/bin/env bash

set -e

export CONFIG="$PWD/cf-rats-config/cf-rats-config.json"

cd routing-release/src/code.cloudfoundry.org/routing-acceptance-tests/

bin/test