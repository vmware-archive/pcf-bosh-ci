#!/usr/bin/env bash

set -e

lpass sync

if [ $# -ne 2 ]  ; then
  echo "USAGE: generate-cert.sh cert-name domain-name"
  exit 1
fi

name=$1
domain=$2

if [ -e "${name}.crt" ] ; then
  echo "SSL private key ${name}.crt already exists. Quitting." >&2
  exit 1
fi

if [ -e "${name}.key" ] ; then
  echo "Using existing SSL private key: ${name}.key"

  openssl req -new -nodes -key "${name}.key" \
	-out "${name}.csr" \
	-subj "/C=US/O=PIVOTAL/CN=${domain}"
else
  openssl req -new -nodes -newkey rsa:2048 \
	-out "${name}.csr" -keyout "${name}.key" \
	-subj "/C=US/O=PIVOTAL/CN=${domain}"
  echo "Generated SSL private key: ${name}.key"
fi

cat >openssl-exts.conf <<-EOL
extensions = san
[san]
subjectAltName = @alt_names

[alt_names]
DNS.1 = *.${domain}
DNS.2 = *.sys.${domain}
DNS.3 = *.app.${domain}
EOL

openssl x509 -req -in "${name}.csr" \
	-CA <(lpass show --notes 3151927421391070000) -CAkey <(lpass show --notes 4260460189418761618) -set_serial "0x$(openssl rand -hex 16)" \
	-out "${name}.crt" -days 99999 \
	-extfile ./openssl-exts.conf
echo "Generated SSL certificate: ${name}.crt"

rm "${name}.csr"
rm ./openssl-exts.conf
