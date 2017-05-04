#!/bin/sh

VERSION=3.3.0
curl -L https://github.com/google/protobuf/archive/v${VERSION}.tar.gz | tar -xz -C ~
cd ~/protobuf-${VERSION}
./autogen.sh
./configure -q --build=x86_64-redhat-linux --host=x86_64-redhat-linux --target=x86_64-redhat-linux
make -j $(nproc) install-strip
