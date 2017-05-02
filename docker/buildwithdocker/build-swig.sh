#!/bin/sh

yum install -y -q pcre2-devel pcre-devel bison byacc

VERSION=3.0.12
curl -L https://sourceforge.net/projects/swig/files/swig/swig-${VERSION}/swig-${VERSION}.tar.gz/download | tar -xz -C ~/
cd swig-${VERSION}
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) install
for item in $(ls -1 /usr/local/bin/*swig*); do file $item | grep -q -s "not stripped" && strip $item; done