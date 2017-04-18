#!/bin/sh

export VERSION=2.2.1
yum install -y -q ncurses-devel
curl -L https://github.com/jonas/tig/releases/download/tig-${VERSION}/tig-${VERSIONI}.tar.gz  | tar -xz -C ~
cd ~/tig-${VERSION}
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) all
make strip
make install
tar -Jcf ~/tig-${VERSION}.txz -C /usr/local .
rm -fr /usr/local/*