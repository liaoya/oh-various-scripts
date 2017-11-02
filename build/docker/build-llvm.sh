#!/bin/bash

# https://www.hiroom2.com/2016/05/28/centos-7-build-llvm-clang-from-svn-repository/
# https://clang.llvm.org/get_started.html

[[ -f /etc/centos-release || -f /etc/oracle-release ]] && yum install -y -q cmake3
[[ -f /etc/fedora-release ]] && dnf install -y -q cmake
[[ -f /etc/lsb-release ]] && grep -w -s -q Ubuntu /etc/lsb-release && apt-get install -y -qq cmake

LLVM_VERSION="5.0.0"

[ -d $HOME/llvm ] && rm -fr ~/llvm
cd ~
curl -L http://releases.llvm.org/${LLVM_VERSION}/llvm-${LLVM_VERSION}.src.tar.xz | tar -xJ -C ~
mv llvm-${LLVM_VERSION}.src llvm
cd $HOME/llvm/tools
curl -L http://releases.llvm.org/${LLVM_VERSION}/cfe-${LLVM_VERSION}.src.tar.xz | tar -xJ -C .
mv cfe-${LLVM_VERSION}.src clang
cd $HOME/llvm/tools/clang/tools
curl -L http://releases.llvm.org/${LLVM_VERSION}/clang-tools-extra-${LLVM_VERSION}.src.tar.xz | tar -xJ -C .
mv clang-tools-extra-${LLVM_VERSION}.src extra
cd $HOME/llvm/projects
curl -L http://releases.llvm.org/${LLVM_VERSION}/compiler-rt-${LLVM_VERSION}.src.tar.xz | tar -xJ -C .
mv compiler-rt-${LLVM_VERSION}.src compiler
cd $HOME/llvm/tools
curl -L http://releases.llvm.org/${LLVM_VERSION}/lld-${LLVM_VERSION}.src.tar.xz | tar -xJ -C .
mv lld-${LLVM_VERSION}.src lld
cd $HOME/llvm/tools
curl -L http://releases.llvm.org/${LLVM_VERSION}/polly-${LLVM_VERSION}.src.tar.xz | tar -xJ -C .
mv polly-${LLVM_VERSION}.src polly
#cd $HOME/llvm/projects
#curl -L http://releases.llvm.org/${LLVM_VERSION}/compiler-rt-${LLVM_VERSION}.src.tar.xz | tar -xJ -C .
#mv compiler-rt-${LLVM_VERSION}.src compiler-rt
cd $HOME/llvm/projects
curl -L http://releases.llvm.org/${LLVM_VERSION}/libcxx-${LLVM_VERSION}.src.tar.xz | tar -xJ -C .
mv libcxx-${LLVM_VERSION}.src libcxx
curl -L http://releases.llvm.org/${LLVM_VERSION}/libcxxabi-${LLVM_VERSION}.src.tar.xz | tar -xJ -C .
mv libcxxabi-${LLVM_VERSION}.src libcxxabi

[ -d $HOME/build ] && rm -fr ~/build
mkdir $HOME/build
cd $HOME/build
cmake3 -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local $HOME/llvm
make -s -j $(nproc)
rm -fr /usr/local
make -s install/strip

tar -Jcf llvm-${LLVM_VERSION}.txz -C /usr/local .
