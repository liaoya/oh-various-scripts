#! /bin/sh

yum install -y -q openssl-devel gnutls-devel nss-devel libssh2-devel zlib-devel c-ares-devel libidn2-devel libnghttp2-devel libpsl-devel libmetalink-devel openldap-devel

VERSION=7.54.1
curl -L https://curl.haxx.se/download/curl-${VERSION}.tar.bz2 | tar -xj -C ~/
cd ~/curl-${VERSION}
./configure -q