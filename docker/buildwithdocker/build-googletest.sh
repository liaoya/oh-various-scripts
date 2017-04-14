#!/bin/sh

yum install -y -q cmake3

VERSION=release-1.8.0
curl -L https://github.com/vim/vim/archive/v${VERSION}.tar.gz | tar -xz -C ~

cd googletest-${VERSION}
mkdir build
cd build
cmake3 -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local ..
make -j $(nproc)
make install/strip
