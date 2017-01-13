# PCF BOSH CI

PCF BOSH CI is a collection of tasks and ops-files to help deploy and manage PCF BOSH.

## BOSH

BOSH is deployed using [https://github.com/cloudfoundry/bosh-deployment](bosh-deployment). The vars necessary to deploy with [tasks/deploy-director.sh](deploy-director.sh) are the same as bosh-deployment with one addition:

- **credhub_aes_key**: A 128-bit hex-encoded AES key (e.g. D673ACD01DA091B08144FBC8C0B5F524)

## Cloud Foundry

Cloud Foundry is deployed using [https://github.com/cloudfoundry/cf-deployment](cf-deployment). The vars necessary to deploy are the same as cf-deployment with some additions. See the [tasks/deploy-ert.sh](deploy-ert.sh) task for the list of variables.

## CF MySQL

MySQL is deployed using [https://github.com/cloudfoundry/cf-mysql-release](cf-mysql-release). No vars are currently required. See the [tasks/deploy-mysql.sh](deploy-mysql.sh) task for details.

## Seed a new environment

To create a new environment, you must first seed your GCS bucket with some empty files. For an environment named new-environment, the following must be created:

- "new-environment"-cf-vars-store.yml
- "new-environment"-mysql-vars-store.yml
- "new-environment"-bosh-vars-store.yml
- "new-environment"-bosh-state.json
  - This file must be valid JSON, so the contents should be `{}`

_Note_: The filenames include double quotation marks, which are required due to Concourse's parameter interpolation.

## Types of deployment

### 1.9-ish

To deploy a ERT reminiscent of PCF 1.9, use the `pipelines/pcf-bosh.yml` pipeline, setting these variables:

- set_to_tag_filter_to_lock_cf_deployment=tag_filter
- p-ert-branch=1.9

_Note_: This includes p-mysql

### Floating

To deploy a ERT using the master of cf-deployment, use the `pipelines/pcf-bosh.yml` pipeline, setting these variables:

- set_to_tag_filter_to_lock_cf_deployment=ignoreme
- p-ert-branch=master

_Note_: This includes p-mysql

### Upgrade

To deploy a pipeline that tests the upgrade process from 1.9 to master, use the `pipelines/upgrade-ert.yml`. No special
 variables are needed.
