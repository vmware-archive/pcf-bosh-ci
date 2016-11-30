FROM golang
MAINTAINER https://github.com/pivotal-cf/pcf-bosh-ci

ADD https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-0.0.123-linux-amd64 /usr/local/bin/bosh

RUN chmod +x /usr/local/bin/bosh