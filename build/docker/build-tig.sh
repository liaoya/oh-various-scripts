#!/bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n $TIG_VERSION && -n $TIG_URL && -n $TIG_SRCDIR ]]; then
    prepare_build "TIG"

    if [ -d ~/$TIG_SRCDIR ]; then
        clear_usrlocal
        cd ~/$TIG_SRCDIR
        ./autogen.sh
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) all
        make -s -j $(nproc) strip
        make -s -j $(nproc) install
        compress_binary tig-${TIG_VERSION}.txz
    else
        echo "Fail to download tig"
    fi
else
    echo "Don't define variable for tig"
fi
