#!/bin/sh

VERSION=3.3.0
curl -L https://github.com/google/protobuf/archive/v${VERSION}.tar.gz | tar -xz -C ~
cd ~/protobuf-${VERSION}
./autogen.sh
./configure -q
make -j $(nproc) install-strip
