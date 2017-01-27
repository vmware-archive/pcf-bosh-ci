FROM ruby
MAINTAINER https://github.com/pivotal-cf/pcf-bosh-ci

RUN apt-get update && apt-get install -y \
    jq \
    prips \
    && rm -rf /var/lib/apt/lists/*

ADD https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-0.0.149-linux-amd64 /usr/local/bin/bosh

RUN chmod +x /usr/local/bin/bosh
