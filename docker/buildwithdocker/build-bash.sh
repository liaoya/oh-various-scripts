#!/bin/sh

yum install -y -q ncurses-devel

VERSION=4.4
curl -L -O http://ftp.gnu.org/gnu/bash/bash-${VERSION}.tar.gz | tar -xz -C ~/
cd ~/bash-${VERSION}
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) install-strip
