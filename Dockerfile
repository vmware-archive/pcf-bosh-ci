FROM golang
MAINTAINER https://github.com/pivotal-cf/pcf-bosh-ci

ADD https://main.bosh-ci.cf-app.com/teams/main/pipelines/bosh:cli/resources/release-bucket-linux /usr/local/bin/bosh

RUN chmod +x /usr/local/bin/bosh