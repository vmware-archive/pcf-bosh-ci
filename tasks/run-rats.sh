#!/usr/bin/env bash

set -e

export CONFIG="$PWD/cf-rats-config/cf-rats-config.json"
export GOPATH="$PWD/routing-release"
export PATH="${GOPATH}/bin":$PATH

cd "$GOPATH/src/code.cloudfoundry.org/routing-acceptance-tests/"

bin/test