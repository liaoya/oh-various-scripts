#!/bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n ${BASH_VERSION} && -n ${BASH_URL} && -n ${BASH_SRCDIR} ]]; then
    prepare_build "BASH"

    if [ -d $HOME/${BASH_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${BASH_SRCDIR}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) install-strip

        compress_binary bash-${BASH_VERSION}.txz /usr/local/bin/bash
        clear_usrlocal
    else
        echo "Fail to download bash"
    fi
else
    echo "Don't define variable for bash"
fi
