#!/bin/sh

yum install -y -q ctags doxygen help2man boost-regex

VERSION=3.1.8
curl -L http://ftp.gnu.org/gnu/src-highlite/source-highlight-${VERSION}.tar.gz | tar -xz -C ~/
cd ~/source-highlight-${VERSION}
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) install-strip