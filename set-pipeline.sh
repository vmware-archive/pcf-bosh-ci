#!/usr/bin/env bash

lpass sync
fly -t local sp -p pcf-bosh -c pipeline.yml -l <(lpass show --notes 5986431050471091932)