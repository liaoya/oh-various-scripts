#!/bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n $UCG_VERSION && -n $UCG_URL && -n $UCG_SRCDIR ]]; then
    prepare_build "UCG"

    if [ -d $HOME/$UCG_SRCDIR ]; then
        clear_usrlocal
        cd $HOME/$UCG_SRCDIR
        ./autogen.sh
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) install-strip

        compress_binary ucg-${UCG_VERSION} /usr/local/bin/ucg
    else
        echo "Fail to download UniversalCodeGrep"
    fi
else
    echo "Don't define variable for UniversalCodeGrep"
fi
