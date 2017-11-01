#!/bin/bash

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n ${SSHPASS_VERSION} && -n ${SSHPASS_URL} && -n ${SSHPASS_SRCDIR} ]]; then
    prepare_build "SSHPASS"

    if [ -d ~/${SSHPASS_SRCDIR} ]; then
        clear_usrlocal
        cd ~/${SSHPASS_SRCDIR}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) install-strip

        compress_binary sshpass-${SSHPASS_VERSION}.txz
    else
        echo "Fail to download sshpass"
    fi
else
    echo "Don't define variable for sshpass"
fi
