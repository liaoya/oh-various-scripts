#!/bin/bash

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n ${GLOBAL_VERSION} && -n ${GLOBAL_URL} && -n ${GLOBAL_SRCDIR} ]]; then
    prepare_build "GLOBAL"

    if [ -d $HOME/${GLOBAL_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${GLOBAL_SRCDIR}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) all
        make -s install-strip

        compress_binary global-${GLOBAL_VERSION}.txz /usr/local/bin/global
    else
        echo "Fail to download global"
    fi
else
    echo "Don't define variable global"
fi
