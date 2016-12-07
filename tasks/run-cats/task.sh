#!/usr/bin/env bash

set -e

export CONFIG
CONFIG="$PWD/cf-cats-config/*.json"

CF_GOPATH=/go/src/github.com/cloudfoundry/

echo "Moving cf-acceptance-tests onto the gopath..."
mkdir -p $CF_GOPATH
cp -R cf-acceptance-tests $CF_GOPATH

cd /go/src/github.com/cloudfoundry/cf-acceptance-tests

./bin/test \
-keepGoing \
-randomizeAllSpecs \
-skipPackage=helpers \
-slowSpecThreshold=120 \
-nodes=6