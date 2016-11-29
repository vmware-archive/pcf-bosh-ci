#!/usr/bin/env bash

set -e

if [ $# -ne 2 ]  ; then
  echo "USAGE: task.sh cert-name domain-name"
  exit 1
fi

name=$1
domain=$2

certs=`dirname $0`/certs

mkdir -p $certs

cd $certs

if [ -e "${name}.crt" ] ; then
  echo "SSL private key certs/${name}.crt already exists. Quitting." >&2
  exit 1
fi

if [ -e "rootCA.key" ] ; then
  echo "Using existing root authority private key: certs/rootCA.key"
else
  if [ -e "rootCA.pem" ] ; then
    echo "Root authority certificate cert/rootCA.cert exists but private key does not. Quitting." >&2
    exit 1
  fi
	openssl genrsa -out rootCA.key 2048
	echo "Generated root authority private key: certs/rootCA.key"
fi

if [ -e "rootCA.pem" ] ; then
  echo "Using existing root authority certificate: certs/rootCA.pem"
else
	yes "" | openssl req -x509 -new -nodes -key rootCA.key \
		-out rootCA.pem -days 99999
  echo "Generated root authority certificate: certs/rootCA.pem"
fi

if [ -e "${name}.key" ] ; then
  echo "Using existing SSL private key: certs/${name}.key"

  openssl req -new -nodes -key ${name}.key \
	-out ${name}.csr \
	-subj "/C=US/O=PIVOTAL/CN=${domain}"
else
  openssl req -new -nodes -newkey rsa:2048 \
	-out ${name}.csr -keyout ${name}.key \
	-subj "/C=US/O=PIVOTAL/CN=${domain}"
  echo "Generated SSL private key: certs/${name}.key"
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

openssl x509 -req -in ${name}.csr \
	-CA rootCA.pem -CAkey rootCA.key -CAcreateserial \
	-out ${name}.crt -days 99999 \
	-extfile ./openssl-exts.conf
echo "Generated SSL certificate: certs/${name}.crt"

rm ${name}.csr
rm ./openssl-exts.conf