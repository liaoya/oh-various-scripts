#!/bin/sh

export VERSION=3.2.0
yum install -y -q gcc-c++ unzip autoconf libtool mingw64-gcc-c++
curl -L https://github.com/google/protobuf/archive/v${VERSION}.tar.gz | tar -xJ -C ~
cd ~/protobuf-${VERSION}
./autogen.sh
mingw64-configure configure --prefix=/work/protoc --with-protoc=/usr/local/bin/protoc
make -j $(nproc)
make install-strip