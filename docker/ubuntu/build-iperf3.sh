#!/bin/sh

rm -fr /usr/local/*

apt-get install -y -qq file libssl-dev

VERSION=3.2
curl -L https://github.com/esnet/iperf/archive/${VERSION}.tar.gz | tar -xz -C ~
cd ~/iperf-${VERSION}
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) install-strip

tar -C /usr/local -cf ~/output/iperf3-$VERSION.txz .