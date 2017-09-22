#!/bin/sh

# c-ares-devel in CentOS 7 is too old
# Only 1.12.0 can be work with GRPC 1.4.0

yum install -y -q zlib-devel openssl-devel gnutls-devel

PROTOBUF_VERSION=3.4.0
curl -L https://github.com/google/protobuf/archive/v${PROTOBUF_VERSION}.tar.gz | tar -xz -C ~
cd ~/protobuf-${PROTOBUF_VERSION}
./autogen.sh
./configure -q
make -j $(nproc) install-strip

VERSION=1.6.1
curl -L https://github.com/grpc/grpc/archive/v${VERSION}.tar.gz | tar -xz -C ~
cd ~/grpc-${VERSION}/third_party/cares
CARES_VERSION=1.12.0
curl -L https://c-ares.haxx.se/download/c-ares-${CARES_VERSION}.tar.gz | tar -xz
[ -d c-ares-${CARES_VERSION} ] && mv c-ares-${CARES_VERSION}/* cares/
cd ~/grpc-${VERSION}/
make -j $(nproc)
make -j $(nproc) strip install
for item in $(ls -1 /usr/local/bin/grpc*plugin); do file $item | grep -q -s "not stripped" && strip -S $item; done

GRPC_JAVA_VERSION=1.6.1
curl -L https://github.com/grpc/grpc-java/archive/v${GRPC_JAVA_VERSION}.tar.gz | tar -xz -C ~
cd ~/grpc-java-${GRPC_JAVA_VERSION}/compiler/src/java_plugin/cpp
g++ -std=c++11 -I/usr/local/include -pthread -L/usr/local/lib -lprotoc -lprotobuf -lpthread -ldl -s -o /usr/local/bin/grpc_java_plugin *.cpp
# git submodule update --recursive --remotecd
# make run_dep_checks
