#!/bin/sh

export VERSION=1.2.3
yum install cmake3 zlib-devel openssl-devel

curl -L https://github.com/grpc/grpc/archive/v${VERSION}.tar.gz | tar -xJ -C ~