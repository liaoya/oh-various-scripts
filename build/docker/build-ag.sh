#!/bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n $AG_VERSION && $AG_URL && $AG_SRCDIR ]]; then
    prepare_build "AG"

    if [ -d ~/$AG_SRCDIR ]; then
        clear_usrlocal
        cd ~/$AG_SRCDIR
        ./autogen.sh
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) install-strip

        compress_binary ag-${AG_VERSION}.txz
    else
        echo "Fail to download silver searcher"
    fi
else
    echo "Don't define variable for silver searcher"
fi
