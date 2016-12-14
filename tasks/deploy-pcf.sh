#!/usr/bin/env bash

source pcf-bosh-ci/scripts/load-director-environment.sh bosh-creds/bosh-creds.yml

cp cf-creds/cf-creds.yml new-cf-creds/cf-creds.yml

bosh -n deploy cf-deployment/cf-deployment.yml \
  --deployment cf \
  --ops-file cf-deployment/opsfiles/gcp.yml \
  --ops-file p-ert/releases.yml \
  --ops-file p-ert/pivotal-defaults.yml \
  --ops-file p-ert/smoke-tests.yml \
  --ops-file pcf-bosh-ci/ops-files/cf-apps-domain.yml \
  --vars-store new-cf-creds/cf-creds.yml \
  --var system_domain=sys.ol-smokey.gcp.pcf-bosh.cf-app.com \
  --var apps_domain=apps.ol-smokey.gcp.pcf-bosh.cf-app.com \
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
  --var "service_backup_release_path=file://$(ls "$PWD"/closed-source-releases/service-backup*.tgz)" \
  --var "service_backup_release_version=17.2.0"
