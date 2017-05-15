#!/bin/sh

dnf install -y -q mingw64-zlib.noarch mingw64-openssl.noarch mingw64-gnutls.noarch mingw64-c-ares.noarch

VERSION=1.3.0
curl -L https://github.com/grpc/grpc/archive/v${VERSION}.tar.gz | tar -xz -C ~
cd ~/grpc-${VERSION}/third_party
PROTOBUF_VERSION=3.3.0
curl -L https://github.com/google/protobuf/archive/v${PROTOBUF_VERSION}.tar.gz | tar -xz -C .
[ -d protobuf-${PROTOBUF_VERSION} ] && rm -fr protobuf && mv protobuf-${PROTOBUF_VERSION} protobuf && cd protobuf && sh autogen.sh
cd ~/grpc-${VERSION}/third_party/cares
CARES_VERSION=1.12.0
curl -L https://c-ares.haxx.se/download/c-ares-${CARES_VERSION}.tar.gz | tar -xz
[ -d c-ares-${CARES_VERSION} ] && mv c-ares-${CARES_VERSION}/* cares/
cd ~/grpc-${VERSION}/
export PKG_CONFIG_PATH=/usr/x86_64-w64-mingw32/sys-root/mingw/lib/pkgconfig:$PKG_CONFIG_PATH
make -j $(nproc)
make strip install