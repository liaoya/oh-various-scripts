#!/bin/bash

yum install -y -q ncurses-devel

VERSION=6.5.7
curl -L http://ftpmirror.gnu.org/gnu/global/global-${VERSION}.tar.gz | tar -xz -C ~/
cd ~/global-${VERSION}
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -s -j $(nproc) all
make install-strip
