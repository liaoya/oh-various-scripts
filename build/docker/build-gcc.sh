#!/bin/bash

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

# https://gcc.gnu.org/install/index.html

if [[ -n ${GCC_VERSION} && -n ${GCC_URL} && -n ${GCC_SRCDIR} ]]; then
    prepare_build "GCC"

    if [ -d $HOME/${GCC_SRCDIR} ]; then
        clear_usrlocal
        mkdir $HOME/gcc-${GCC_VERSION}-build
        cd $HOME/gcc-${GCC_VERSION}-build
        sh $HOME/${GCC_SRCDIR}/configure --disable-multilib --enable-languages=c,c++,go,fortran --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) 
        make -s -j $(nproc) install-strip

        compress_binary gcc-${GCC_VERSION}.txz /usr/local/bin/gcc
    else
        echo "Fail to download gcc"
    fi
else
    echo "Don't define variable gcc"
fi
