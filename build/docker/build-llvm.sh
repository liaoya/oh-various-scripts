#!/bin/bash

# https://www.hiroom2.com/2016/05/28/centos-7-build-llvm-clang-from-svn-repository/
# https://clang.llvm.org/get_started.html

[[ -f ../env.sh ]] && source ../env.sh

install_deps "LLVM"

download_source http://releases.llvm.org/${LLVM_VERSION}/llvm-${LLVM_VERSION}.src.tar.xz
download_source http://releases.llvm.org/${LLVM_VERSION}/cfe-${LLVM_VERSION}.src.tar.xz
download_source http://releases.llvm.org/${LLVM_VERSION}/clang-tools-extra-${LLVM_VERSION}.src.tar.xz
download_source http://releases.llvm.org/${LLVM_VERSION}/compiler-rt-${LLVM_VERSION}.src.tar.xz
download_source http://releases.llvm.org/${LLVM_VERSION}/lld-${LLVM_VERSION}.src.tar.xz
download_source http://releases.llvm.org/${LLVM_VERSION}/polly-${LLVM_VERSION}.src.tar.xz
# download_source http://releases.llvm.org/${LLVM_VERSION}/compiler-rt-${LLVM_VERSION}.src.tar.xz
download_source http://releases.llvm.org/${LLVM_VERSION}/libcxx-${LLVM_VERSION}.src.tar.xz
download_source http://releases.llvm.org/${LLVM_VERSION}/libcxxabi-${LLVM_VERSION}.src.tar.xz

[ -d ${HOME}/llvm ] && rm -fr ~/llvm
cd $HOME
tar -Jxf llvm-${LLVM_VERSION}.src.tar.xz && mv llvm-${LLVM_VERSION}.src llvm
tar -Jxf cfe-${LLVM_VERSION}.src.tar.xz -C $HOME/llvm/tools && mv $HOME/llvm/tools/cfe-${LLVM_VERSION}.src $HOME/llvm/tools/clang
tar -Jxf clang-tools-extra-${LLVM_VERSION}.src.tar.xz -C $HOME/llvm/tools/clang/tools && mv $HOME/llvm/tools/clang/tools/clang-tools-extra-${LLVM_VERSION}.src $HOME/llvm/tools/clang/tools/extra
tar -Jxf compiler-rt-${LLVM_VERSION}.src.tar.xz -C $HOME/llvm/projects && mv $HOME/llvm/projects/compiler-rt-${LLVM_VERSION}.src $HOME/llvm/projects/compiler
tar -Jxf lld-${LLVM_VERSION}.src.tar.xz -C $HOME/llvm/tools && mv $HOME/llvm/tools/lld-${LLVM_VERSION}.src $HOME/llvm/tools/lld
tar -Jxf polly-${LLVM_VERSION}.src.tar.xz -C $HOME/llvm/tools && mv $HOME/llvm/tools/polly-${LLVM_VERSION}.src $HOME/llvm/tools/polly
# tar -Jxf compiler-rt-${LLVM_VERSION}.src.tar.xz -C $HOME/llvm/projects && mv $HOME/llvm/projects/compiler-rt-${LLVM_VERSION}.src $HOME/llvm/projects/compiler-rt
tar -Jxf libcxx-${LLVM_VERSION}.src.tar.xz -C $HOME/llvm/projects && mv $HOME/llvm/projects/libcxx-${LLVM_VERSION}.src $HOME/llvm/projects/libcxx
tar -Jxf libcxxabi-${LLVM_VERSION}.src.tar.xz -C $HOME/llvm/projects && mv $HOME/llvm/projects/libcxxabi-${LLVM_VERSION}.src $HOME/llvm/projects/libcxxabi

[ -d $HOME/build ] && rm -fr $HOME/build
mkdir $HOME/build
cd $HOME/build
cmake3 -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local $HOME/llvm
make -s -j $(nproc)
rm -fr /usr/local
make -s install/strip

compress_binary llvm-${LLVM_VERSION} /usr/local/bin/clang
