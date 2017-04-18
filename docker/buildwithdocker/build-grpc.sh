#!/bin/sh

VERSION=1.2.3
yum install -y -q zlib-devel openssl-devel

curl -L https://github.com/grpc/grpc/archive/v${VERSION}.tar.gz | tar -xJ -C ~
cd grpc-${VERSION}/third_party
rm -fr protobuf
PROTOBUF_VERSION=3.2.0
curl -L https://github.com/google/protobuf/archive/v{PROTOBUF_VERSION}.tar.gz | tar -xJ -C ~
mv protobuf-${PROTOBUF_VERSION} protobuf
cd ..
make -j $(nproc)
make install
for item in $(ls -1 /usr/local/bin/*); do strip $item; done
