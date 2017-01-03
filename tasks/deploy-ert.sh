#!/usr/bin/env bash

set -e

eval "$(pcf-bosh-ci/scripts/director-environment bosh-creds/*-bosh-creds.yml terraform-state/metadata)"

cp cf-creds/*-cf-creds.yml new-cf-creds/cf-creds.yml

bosh -n deploy cf-deployment/cf-deployment.yml \
  --deployment cf \
  --ops-file cf-deployment/opsfiles/gcp.yml \
  --ops-file cf-deployment/opsfiles/tcp-routing-gcp.yml \
  --ops-file p-ert/releases.yml \
  --ops-file p-ert/pivotal-defaults.yml \
  --ops-file p-ert/mysql-proxy.yml \
  --ops-file p-ert/mysql-monitoring.yml \
  --ops-file p-ert/smoke-tests.yml \
  --ops-file p-ert/push-apps-manager.yml \
  --ops-file p-ert/deploy-notifications.yml \
  --ops-file p-ert/deploy-notifications-ui.yml \
  --ops-file p-ert/deploy-autoscaling.yml \
  --ops-file p-ert/autoscaling-register-broker.yml \
  --ops-file p-ert/autoscaling-destroy-broker.yml \
  --ops-file p-ert/mysql-bootstrap.yml \
  --vars-store new-cf-creds/cf-creds.yml \
  --var "system_domain=$(jq -r .sys_domain terraform-state/metadata)" \
  --var "apps_domain=$(jq -r .apps_domain terraform-state/metadata)" \
  --var "cf_release_path=file://$(ls "$PWD"/closed-source-releases/cf-246*.tgz)" \
  --var "cf_release_version=246.0.2" \
  --var "postgres_release_path=file://$(ls "$PWD"/closed-source-releases/postgres*.tgz)" \
  --var "postgres_release_version=8" \
  --var "notifications_release_path=file://$(ls "$PWD"/closed-source-releases/notifications-31*.tgz)" \
  --var "notifications_release_version=31" \
  --var "notifications_ui_release_path=file://$(ls "$PWD"/closed-source-releases/notifications-ui*.tgz)" \
  --var "notifications_ui_release_version=26" \
  --var "cf_autoscaling_release_path=file://$(ls "$PWD"/closed-source-releases/cf-autoscaling*.tgz)" \
  --var "cf_autoscaling_release_version=67" \
  --var "push_apps_manager_release_path=file://$(ls "$PWD"/closed-source-releases/push-apps-manager*.tgz)" \
  --var "push_apps_manager_release_version=659.7" \
  --var "mysql_monitoring_release_path=file://$(ls "$PWD"/closed-source-releases/mysql-monitoring*.tgz)" \
  --var "mysql_monitoring_release_version=6" \
  --var "mysql_backup_release_path=file://$(ls "$PWD"/closed-source-releases/mysql-backup*.tgz)" \
  --var "mysql_backup_release_version=1.28.0" \
  --var "pivotal_account_release_path=file://$(ls "$PWD"/closed-source-releases/pivotal-account*.tgz)" \
  --var "pivotal_account_release_version=1" \
  --var "service_backup_release_path=file://$(ls "$PWD"/closed-source-releases/service-backup*.tgz)" \
  --var "service_backup_release_version=17.2.0"
