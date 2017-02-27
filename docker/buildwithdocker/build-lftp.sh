#!/bin/sh

export VERSION=4.7.6
yum install -y -q ncurses-devel readline-devel gnutls-devel zlib-devel libidn-devel
curl -L http://lftp.yar.ru/ftp/lftp-${VERSION}.tar.xz | tar -xJ -C ~
cd ~/lftp-${VERSION}
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) all
make install-strip install-man
tar -Jcf ~/lftp-${VERSION}.txz -C /usr/local .
rm -fr /usr/local/*