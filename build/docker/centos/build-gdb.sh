#!/bin/bash

 yum install -y -q bison flex expect

VERSION=8.0.1
curl -L http://ftpmirror.gnu.org/gdb/gdb-${VERSION}.tar.xz | tar -Jx -C ~/
mkdir -p gdb-${VERSION}/build
cd gdb-${VERSION}/build
sh ../configure
make -s -j $(nproc)
