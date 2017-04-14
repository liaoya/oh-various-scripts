#!/bin/sh

VERSION=2.2.0
yum install cmake3

curl -L https://github.com/gflags/gflags/archive/v${VERSION}.tar.gz | tar -xz -C ~
cd gflags-v${VERSION}
mkdir build && cd build
cmake3 -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local ..
make install/strip