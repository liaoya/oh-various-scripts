#!/bin/sh

export VERSION=3.2.0
yum install -y -q gcc-c++ unzip autoconf libtool
curl -L https://github.com/google/protobuf/archive/v{version}.tar.gz | tar -xJ -C ~
cd ~/protobuf-${VERSION}
yum install -y -q unzip libtool
./autogen.sh
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc)
make install-strip
