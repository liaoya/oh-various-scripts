#!/bin/sh

VERSION=3.2.0
yum install -y -q gcc-c++ unzip autoconf automake libtool curl
curl -L https://github.com/google/protobuf/archive/v${VERSION}.tar.gz | tar -xJ -C ~
cd ~/protobuf-${VERSION}
./autogen.sh
./configure -q --build=x86_64-redhat-linux --host=x86_64-redhat-linux --target=x86_64-redhat-linux
make -j $(nproc)
make install-strip
