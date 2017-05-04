#!/bin/sh

# Need Improve

yum install -y -q zlib-devel openssl-devel gnutls-devel c-ares-devel 

VERSION=1.3.0
curl -L https://github.com/grpc/grpc/archive/v${VERSION}.tar.gz | tar -xz -C ~
cd ~/grpc-${VERSION}/third_party
PROTOBUF_VERSION=3.3.0
curl -L https://github.com/google/protobuf/archive/v${PROTOBUF_VERSION}.tar.gz | tar -xz -C .
[ -d protobuf-${PROTOBUF_VERSION} ] && rm -fr protobuf && mv protobuf-${PROTOBUF_VERSION} protobuf && cd protobuf && ./autogen.sh
cd ~/grpc-${VERSION}/third_party/cares
CARES_VERSION=1.12.0
curl -L https://c-ares.haxx.se/download/c-ares-${CARES_VERSION}.tar.gz | tar -xz
[ -d c-ares-${CARES_VERSION} ] && mv c-ares-${CARES_VERSION}/* cares/
cd ~/grpc-${VERSION}/
make -j $(nproc)
make strip install
for item in $(ls -1 /usr/local/bin/grpc*plugin); do file $item | grep -q -s "not stripped" && strip $item; done

# git submodule update --recursive --remotecd
# make run_dep_checks
