#!/bin/sh

yum install -y -q lua-devel boost-devel

VERSION=3.39
curl -L -O http://www.andre-simon.de/zip/highlight-${VERSION}.tar.bz2
tar -C ~/ -xf highlight-${VERSION}.tar.bz2
cd ~/highlight-${VERSION}
sed -i "s/PREFIX = \/usr/PREFIX = \/usr\/local/g" makefile
make -j $(nproc)
strip src/highlight
make install
