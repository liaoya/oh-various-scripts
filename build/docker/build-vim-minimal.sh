#!/bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n $VIM_VERSION && -n $VIM_URL && -n $VIM_SRCDIR ]]; then
    prepare_build "VIM"

    if [ -d ~/$VIM_SRCDIR ]; then
        clear_usrlocal
        cd ~/$VIM_SRCDIR
        ./configure -q --with-features=tiny --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) install

        compress_binary vim-minimal-${VIM_VERSION}.txz
    else
        echo "Fail to download vim-minimal"
    fi
else
    echo "Don't define variable for vim-minimal"
fi