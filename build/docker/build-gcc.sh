#!/bin/bash

[[ -f ../env.sh ]] && source ../env.sh
# https://gcc.gnu.org/install/index.html

if [[ -n ${GCC_VERSION} && -n ${GCC_URL} && -n ${GCC_SRCDIR} ]]; then
    prepare_build "gcc"

    if [ -d $HOME/${GCC_SRCDIR} ]; then
        clear_usrlocal
        mkdir $HOME/gcc-${GCC_VERSION}-build
        cd $HOME/gcc-${GCC_VERSION}-build
        sh $HOME/${GCC_SRCDIR}/configure --disable-multilib --enable-languages=c,c++,go,fortran --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) 
        make -s -j $(nproc) install-strip

        compress_binary gcc-${GCC_VERSION} /usr/local/bin/gcc
    else
        echo "Fail to download gcc"
    fi
else
    echo "Don't define variable gcc"
fi
