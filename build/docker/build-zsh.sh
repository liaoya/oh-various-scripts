#!/bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n ${ZSH_VERSION} && -n ${ZSH_URL} && -n ${ZSH_SRCDIR} ]]; then
    prepare_build "ZSH"

    if [ -d $HOME/${ZSH_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${ZSH_SRCDIR}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) all
        make -s install-strip

        compress_binary zsh-${ZSH_VERSION}.txz /usr/local/bin/zsh
    else
        echo "Fail to download zsh"
    fi
else
    echo "Don't define variable zsh"
fi
