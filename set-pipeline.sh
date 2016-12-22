#!/usr/bin/env bash

lpass sync
fly -t wings sp -p pcf-bosh -c pipelines/pcf-bosh.yml -l <(lpass show --notes 5986431050471091932) --var env_name=ol-smokey