#!/bin/sh

rm -fr /usr/local/*

apt-get install -y -qq libncurses-dev

VERSION=2.2.2
curl -L https://github.com/jonas/tig/releases/download/tig-${VERSION}/tig-${VERSION}.tar.gz  | tar -xz -C ~
cd ~/tig-${VERSION}
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) all
make -j $(nproc) strip
make -j $(nproc) install

tar -C /usr/local -cf ~/output/tig-$VERSION.txz .