#!/bin/bash

yum install -y -q ncurses-devel

VERSION=6.5.6
curl -L http://tamacom.com/global/global-${VERSION}.tar.gz | tar -xz -C ~/
cd global-${VERSION}
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) all
make install-strip
