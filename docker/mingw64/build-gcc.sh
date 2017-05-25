#!/bin/bash

# https://gcc.gnu.org/install/index.html
# lack mpc and fail to build

yum install -y -q mingw64-gmp.noarch mingw64-mpfr.noarch wget
export VERSION=7.1.0
curl -L http://ftpmirror.gnu.org/gcc/gcc-${VERSION}/gcc-${VERSION}.tar.bz2 | tar -jx -C ~/
cd ../gcc-${VERSION} && sh contrib/download_prerequisites
mkdir ~/build
cd ~/build
sh ../gcc-${VERSION}/configure --disable-multilib --enable-languages=c,c++,fortran --host=x86_64-w64-mingw32 --build=x86_64-redhat-linux-gnu \
--prefix=/usr/local/mingw64 --exec-prefix=/usr/local/mingw64 --bindir=/usr/local/mingw64/bin --sbindir=/usr/local/mingw64/sbin \
--sysconfdir=/usr/local/mingw64/etc --datadir=/usr/local/mingw64/share --includedir=/usr/local/mingw64/include --libdir=/usr/local/mingw64/lib \
--libexecdir=/usr/local/mingw64/libexec --localstatedir=/usr/local/mingw64/var --sharedstatedir=/usr/local/mingw64/com \
--mandir=/usr/local/mingw64/share/man --infodir=/usr/local/mingw64/share/info
make -j $(nproc) 
make -j $(nproc) install-strip