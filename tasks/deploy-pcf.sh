#!/usr/bin/env bash

source pcf-bosh-ci/scripts/load-director-environment.sh bosh-creds/bosh-creds.yml

cp cf-creds/cf-creds.yml new-cf-creds/cf-creds.yml

bosh -n deploy cf-deployment/cf-deployment.yml \
  --deployment cf \
  --ops-file cf-deployment/opsfiles/gcp.yml \
  --ops-file pcf-bosh-ci/ops-files/cf-apps-domain.yml \
  --vars-store new-cf-creds/cf-creds.yml \
  --var system_domain=sys.ol-smokey.gcp.pcf-bosh.cf-app.com \
  --var notifications_ui_release_path="file://$PWD/notifications-ui-release/notifications-ui*.tgz" \
  --var notifications_ui_release_version="file://$PWD/notifications-ui-release/version" \
  --var cf_autoscaling_release_path="file://$PWD/cf-autoscaling-release/cf-autoscaling*.tgz" \
  --var cf_autoscaling_release_version="file://$PWD/cf-autoscaling-release/version" \
  --var console_release_path="file://$PWD/console-release/*.tgz" \
  --var console_release_version="file://$PWD/console-release/version" \
  --var cf_release_path="file://$PWD/cf-release/*.tgz" \
  --var postgres_release_path="file://$PWD/postgres-release/*.tgz" \
  --var cf_release_version="file://$PWD/cf-release/version" \
  --var postgres_release_version="file://$PWD/postgres-release/version" \
  --var mysql_monitoring_release_path="file://$PWD/mysql-monitoring-release/*.tgz" \
  --var mysql_monitoring_release_version="file://$PWD/mysql-monitoring-release/version" \
  --var mysql_backup_release_path="file://$PWD/mysql-backup-release/*.tgz" \
  --var mysql_backup_release_version="file://$PWD/mysql-backup-release/version"

#  --var service_backup_release_path="file://$PWD/service-backup-release/service-backup*.tgz"
#  --var service_backup_release_version="file://$PWD/service-backup-release/version"
#  --var pivotal_account_release_path="file://$PWD/pivotal-account-release/pivotal-account*.tgz"
#  --var pivotal_account_release_version="file://$PWD/pivotal-account-release/version"
