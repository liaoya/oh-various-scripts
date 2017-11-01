#!/bin/bash

# https://gcc.gnu.org/install/index.html

yum install -y -q gmp-devel libmpc-devel

VERSION=7.2.0
curl -L http://ftpmirror.gnu.org/gnu/gcc/gcc-${VERSION}/gcc-${VERSION}.tar.xz | tar -Jx -C ~/
mkdir ~/build
cd ~/build
sh ../gcc-${VERSION}/configure --disable-multilib --enable-languages=c,c++,go,fortran --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -s -j $(nproc) 
make -s -j $(nproc) install-strip
