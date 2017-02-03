#!/usr/bin/env bash

set -e

eval "$(pcf-bosh-ci/scripts/director-environment bosh-vars-store/*-bosh-vars-store.yml terraform-state/metadata)"

cp cf-vars-store/*-cf-vars-store.yml new-cf-vars-store/cf-vars-store.yml

bosh -n deploy cf-deployment/cf-deployment.yml \
  --deployment cf \
  --ops-file cf-deployment/opsfiles/change-logging-port-for-aws-elb.yml \
  --ops-file p-ert/pivotal-defaults.yml \
  --ops-file p-ert/mysql-proxy.yml \
  --ops-file p-ert/mysql-monitoring.yml \
  --ops-file p-ert/errands/smoke-tests.yml \
  --ops-file p-ert/errands/push-apps-manager.yml \
  --ops-file p-ert/errands/deploy-notifications.yml \
  --ops-file p-ert/errands/deploy-notifications-ui.yml \
  --ops-file p-ert/errands/deploy-autoscaling.yml \
  --ops-file p-ert/errands/autoscaling-register-broker.yml \
  --ops-file p-ert/errands/autoscaling-destroy-broker.yml \
  --ops-file p-ert/errands/push-pivotal-account.yml \
  --ops-file p-ert/errands/mysql-recovery/bootstrap.yml \
  --ops-file p-ert/errands/mysql-recovery/rejoin-unsafe.yml \
  --ops-file p-ert/aws/ip-overrides.yml \
  --ops-file p-ert/s3.yml \
  --ops-file p-ert/external-mysql.yml \
  --vars-store new-cf-vars-store/cf-vars-store.yml \
  --var "cc_s3_access_key=$(jq -r .ert_iam_user_access_key terraform-state/metadata)" \
  --var "cc_s3_secret_key=$(jq -r .ert_iam_user_secret_access_key terraform-state/metadata)" \
  --var "cc_s3_bucket_name=$(jq -r .cloud_controller_bucket terraform-state/metadata)" \
  --var "system_domain=$(jq -r .sys_domain terraform-state/metadata)" \
  --var "apps_domain=$(jq -r .apps_domain terraform-state/metadata)" \
  --var "smtp_host_name=$SMTP_HOST_NAME" \
  --var "smtp_host_port=$SMTP_HOST_PORT" \
  --var "smtp_sender_username=$SMTP_SENDER_USERNAME" \
  --var "smtp_sender_password=$SMTP_SENDER_PASSWORD" \
  --var "external_mysql_host=$(jq -r .rds_address terraform-state/metadata)" \
  --var "external_mysql_port=$(jq -r .rds_port terraform-state/metadata)" \
  --var "external_mysql_username=$(jq -r .rds_username terraform-state/metadata)" \
  --var "external_mysql_password=$(jq -r .rds_password terraform-state/metadata)" \
  --var "cf_release_path=file://$(ls "$PWD"/closed-source-releases/cf-246*.tgz)" \
  --var "cf_release_version=246.0.2" \
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
  --var "pivotal_account_release_path=file://$(ls "$PWD"/closed-source-releases/pivotal-account*.tgz)" \
  --var "pivotal_account_release_version=1"
