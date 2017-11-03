#!/bin/bash

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n $AXEL_VERSION && -n $AXEL_URL && -n $AXEL_SRCDIR ]]; then
    prepare_build "AXEL"

    if [ -d $HOME/$AXEL_SRCDIR ]; then
        clear_usrlocal
        cd $HOME/$AXEL_SRCDIR
        ./autogen.sh
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc)
        make -s install-strip

        compress_binary axel-${AXEL_VERSION} /usr/local/bin/axel
    else
        echo "Fail to download silver searcher"
    fi
else
    echo "Don't define variable for silver searcher"
fi
