#!/usr/bin/env bash

set -e

eval "$(pcf-bosh-ci/scripts/director-environment bosh-vars-store/*-bosh-vars-store.yml terraform-state/metadata)"

z1_cidr=$(jq -r .ert_subnet_cidrs[0] terraform-state/metadata)
z2_cidr=$(jq -r .ert_subnet_cidrs[1] terraform-state/metadata)
z3_cidr=$(jq -r .ert_subnet_cidrs[2] terraform-state/metadata)

function nthIp() {
    cidr=$1
    n=$2
    prips "$cidr" | awk -v number="$n" 'NR==number {print $0}'
}

cat <<BOSHVARS > bosh-vars.yml
---
z1: $(jq -r .azs[0] terraform-state/metadata)
z2: $(jq -r .azs[1] terraform-state/metadata)
z3: $(jq -r .azs[2] terraform-state/metadata)
z1_subnet_id: $(jq -r .ert_subnet_ids[0] terraform-state/metadata)
z1_cidr: $z1_cidr
z1_gateway: $(nthIp $z1_cidr 2)
z1_reserved_ips: ["$(nthIp $z1_cidr 1)-$(nthIp $z1_cidr 4)", "$(nthIp $z1_cidr 256)"]
z1_static_ips: ["$(nthIp $z1_cidr 191)-$(nthIp $z1_cidr 255)"]
z2_subnet_id: $(jq -r .ert_subnet_ids[2] terraform-state/metadata)
z2_cidr: $z2_cidr
z2_gateway: $(nthIp $z2_cidr 2)
z2_reserved_ips: ["$(nthIp $z2_cidr 1)-$(nthIp $z2_cidr 4)", "$(nthIp $z2_cidr 256)"]
z2_static_ips: ["$(nthIp $z2_cidr 191)-$(nthIp $z2_cidr 255)"]
z3_subnet_id: $(jq -r .ert_subnet_ids[2] terraform-state/metadata)
z3_cidr: $z3_cidr
z3_gateway: $(nthIp $z3_cidr 2)
z3_reserved_ips: ["$(nthIp $z3_cidr 1)-$(nthIp $z3_cidr 4)", "$(nthIp $z3_cidr 256)"]
z3_static_ips: ["$(nthIp $z3_cidr 191)-$(nthIp $z3_cidr 255)"]
router_lb: $(jq -r .router_elb terraform-state/metadata)
router_lb_security_groups: ["$(jq -r .router_elb_security_group_id terraform-state/metadata)"]
ssh_proxy_lb: $(jq -r .ssh_elb terraform-state/metadata)
ssh_proxy_lb_security_groups: ["$(jq -r .ssh_elb_security_group_id terraform-state/metadata)"]
BOSHVARS

bosh -n update-cloud-config cloud-config/aws/cloud-config.yml --vars-file bosh-vars.yml
