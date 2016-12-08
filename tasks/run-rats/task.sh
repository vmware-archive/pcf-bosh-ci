#!/usr/bin/env bash

set -e

export CONFIG="$PWD/cf-rats-config/cf-rats-config.json"
export GOPATH="$PWD/routing-release"

cd "$GOPATH/src/code.cloudfoundry.org/routing-acceptance-tests/"

bin/test