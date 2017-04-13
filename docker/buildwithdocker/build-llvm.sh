#!/bin/bash

# https://www.hiroom2.com/2016/05/28/centos-7-build-llvm-clang-from-svn-repository/
# https://clang.llvm.org/get_started.html

yum install -y -q cmake3

VERSION="4.0.0"

[ -d ~/llvm ] && rm -fr llvm
curl -L http://releases.llvm.org/${VERSION}/llvm-${VERSION}.src.tar.xz | tar -xJ -C ~
mv llvm-${VERSION}.src llvm
cd llvm/tools
curl -L http://releases.llvm.org/${VERSION}/cfe-${VERSION}.src.tar.xz | tar -xJ -C .
mv cfe-${VERSION}.src clang
cd ../../llvm/tools/clang/tools
curl -L http://releases.llvm.org/${VERSION}/clang-tools-extra-${VERSION}.src.tar.xz | tar -xJ -C .
mv clang-tools-extra-${VERSION}.src extra
cd ../../../../llvm/projects
curl -L http://releases.llvm.org/${VERSION}/compiler-rt-${VERSION}.src.tar.xz | tar -xJ -C .
mv compiler-rt-${VERSION}.src compiler
cd ../..
mkdir build
cd build
cmake3 -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ../llvm
make -j $(nproc)
make install/strip
