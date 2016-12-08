FROM golang
MAINTAINER https://github.com/pivotal-cf/pcf-bosh-ci

RUN apt-get update && apt-get install -y \
    jq \
    ruby \
    unzip # Used by V3 CATs \
    && rm -rf /var/lib/apt/lists/*

ADD https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-0.0.131-linux-amd64 /usr/local/bin/bosh

RUN chmod +x /usr/local/bin/bosh

# Install the cf CLI
RUN wget -q -O cf.deb "https://cli.run.pivotal.io/stable?release=debian64&source=github-rel" && \
  dpkg -i cf.deb

# Install the container networking CLI plugin
RUN wget -q -O /tmp/network-policy-plugin "https://github.com/cloudfoundry-incubator/netman-release/releases/download/v0.5.0/network-policy-plugin-linux64" && \
  chmod +x /tmp/network-policy-plugin && \
  cf install-plugin /tmp/network-policy-plugin -f && \
  rm -rf /tmp/*

# Install the routing cli
RUN wget -q https://github.com/cloudfoundry-incubator/routing-api-cli/releases/download/2.7.0/rtr-linux-amd64.tgz && \
    tar -xvf rtr-linux-amd64.tgz && \
    chmod +x rtr-linux-amd64 && \
    mv rtr-linux-amd64 /usr/local/bin/rtr && \
    rm rtr-linux-amd64.tgz
