#!/bin/bash

# https://www.hiroom2.com/2016/05/28/centos-7-build-llvm-clang-from-svn-repository/
# https://clang.llvm.org/get_started.html

[[ -f /etc/centos-release || -f /etc/oracle-release ]] && yum install -y -q cmake3
[[ -f /etc/fedora-release ]] && dnf install -y -q cmake
[[ -f /etc/lsb-release ]] && grep -w -s -q Ubuntu /etc/lsb-release && apt-get install -y -qq cmake

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

download_source http://releases.llvm.org/${LLVM_VERSION}/llvm-${LLVM_VERSION}.src.tar.xz
download_source http://releases.llvm.org/${LLVM_VERSION}/cfe-${LLVM_VERSION}.src.tar.xz
download_source http://releases.llvm.org/${LLVM_VERSION}/clang-tools-extra-${LLVM_VERSION}.src.tar.xz
download_source http://releases.llvm.org/${LLVM_VERSION}/compiler-rt-${LLVM_VERSION}.src.tar.xz
download_source http://releases.llvm.org/${LLVM_VERSION}/lld-${LLVM_VERSION}.src.tar.xz
download_source http://releases.llvm.org/${LLVM_VERSION}/polly-${LLVM_VERSION}.src.tar.xz
# download_source http://releases.llvm.org/${LLVM_VERSION}/compiler-rt-${LLVM_VERSION}.src.tar.xz
download_source http://releases.llvm.org/${LLVM_VERSION}/libcxx-${LLVM_VERSION}.src.tar.xz
download_source http://releases.llvm.org/${LLVM_VERSION}/libcxxabi-${LLVM_VERSION}.src.tar.xz

[ -d $HOME/llvm ] && rm -fr ~/llvm
cd $HOME
tar -Jxf ${LLVM_VERSION}/llvm-${LLVM_VERSION}.src.tar.xz && mv llvm-${LLVM_VERSION}.src llvm
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

compress_binary zsh-${LLVM_VERSION}.txz /usr/local/bin/clang
