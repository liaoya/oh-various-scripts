#!/bin/bash

# https://gcc.gnu.org/install/index.html

yum install -y -q gmp-devel libmpc-devel

export VERSION=7.2.0
curl -L http://ftpmirror.gnu.org/gcc/gcc-${VERSION}/gcc-${VERSION}.tar.bz2 | tar -jx -C ~/
mkdir ~/build
cd ~/build
sh ../gcc-${VERSION}/configure --disable-multilib --enable-languages=c,c++,go,fortran --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) 
make -j $(nproc) install-strip