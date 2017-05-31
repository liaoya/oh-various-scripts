#!/bin/bash

 yum install -y -q bison flex expect

VERSION=7.12.1
curl -L http://ftpmirror.gnu.org/gdb/gdb-${VERSION}.tar.xz | tar -Jx -C ~/
mkdir -p gdb-${VERSION}/build
cd gdb-${VERSION}/build
sh ../configure
make -j $(nproc)