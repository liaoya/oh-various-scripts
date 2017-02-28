#!/bin/sh

VERSION=8.0.0386
curl -L https://github.com/vim/vim/archive/v${VERSION}.tar.gz | tar -xz -C ~
yum install -y -q ncurses-devel
cd ~/vim-${VERSION}
./configure -q --with-features=tiny --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) install
tar -Jcf ~/vim-minimal-${VERSION}.txz -C /usr/local .
rm -fr /usr/local/*
make clean
