#!/usr/bin/env bash

set -e

eval "$(pcf-bosh-ci/scripts/director-environment bosh-creds/*-bosh-creds.yml terraform-state/metadata)"

cat <<BOSHVARS > bosh-vars.yml
---
internal_cidr: $(jq -r .cf_cidr terraform-state/metadata)
internal_gw: $(jq -r .cf_gateway terraform-state/metadata)
network: $(jq -r .network_name terraform-state/metadata)
subnetwork: $(jq -r .cf_subnet terraform-state/metadata)
internal_tags: $(jq -r .cf_internal_tags terraform-state/metadata)
http_backend_service: $(jq -r .http_lb_backend_name terraform-state/metadata)
ws_target_pool: $(jq -r .ws_router_pool terraform-state/metadata)
public_tags: $(jq -r .cf_public_tags terraform-state/metadata)
tcp_target_pool: $(jq -r .tcp_router_pool terraform-state/metadata)
tcp_tags: $(jq -r .cf_tcp_tags terraform-state/metadata)
ssh_target_pool: $(jq -r .ssh_router_pool terraform-state/metadata)
ssh_tags: $(jq -r .cf_ssh_tags terraform-state/metadata)
z1: $(jq -r .azs[0] terraform-state/metadata)
z2: $(jq -r .azs[1] terraform-state/metadata)
z3: $(jq -r .azs[2] terraform-state/metadata)
reserved_ips: $(jq -r .cf_reserved_ips terraform-state/metadata)
static_ip_start: $(jq -r .cf_static_ip_start terraform-state/metadata)
static_ip_end: $(jq -r .cf_static_ip_end terraform-state/metadata)
BOSHVARS

bosh -n update-cloud-config cloud-config/cloud-config.yml --vars-file bosh-vars.yml
