#!/bin/sh

yum install -y -q ncurses-devel libacl-devel

VERSION=8.0.0566
curl -L https://github.com/vim/vim/archive/v${VERSION}.tar.gz | tar -xz -C ~

cd ~/vim-${VERSION}
./configure -q --with-features=tiny --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) install
