#!/bin/sh

# Need Improve

yum install -y -q zlib-devel openssl-devel gnutls-devel c-ares-devel

PROTOBUF_VERSION=3.3.0
curl -L https://github.com/google/protobuf/archive/v${PROTOBUF_VERSION}.tar.gz | tar -xz -C ~
cd ~/protobuf-${PROTOBUF_VERSION}
./autogen.sh
./configure -q
make -j $(nproc) install-strip

GRPC_VERSION=1.3.4
curl -L https://github.com/grpc/grpc/archive/v${GRPC_VERSION}.tar.gz | tar -xz -C ~
cd ~/grpc-${GRPC_VERSION}/third_party/cares
CARES_VERSION=1.12.0
curl -L https://c-ares.haxx.se/download/c-ares-${CARES_VERSION}.tar.gz | tar -xz
[ -d c-ares-${CARES_VERSION} ] && mv c-ares-${CARES_VERSION}/* cares/
cd ~/grpc-${GRPC_VERSION}/
make -j $(nproc)
make -j $(nproc) strip install
for item in $(ls -1 /usr/local/bin/grpc*plugin); do file $item | grep -q -s "not stripped" && strip $item; done

JAVA_VERSION=1.3.0
curl -L https://github.com/grpc/grpc-java/archive/v${JAVA_VERSION}.tar.gz | tar -xz -C ~
cd ~/grpc-java-${JAVA_VERSION}/compiler/src/java_plugin/cpp
g++ -std=c++11 -I/usr/local/include -pthread -L/usr/local/lib -lprotoc -lprotobuf -lpthread -ldl -s -o /usr/local/bin/grpc_java_plugin *.cpp
# git submodule update --recursive --remotecd
# make run_dep_checks
