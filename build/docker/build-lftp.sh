#!/bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n ${LFTP_VERSION} && -n ${LFTP_URL} && -n ${LFTP_SRCDIR} ]]; then
    prepare_build "LFTP"

    if [ -d ~/${LFTP_SRCDIR} ]; then
        clear_usrlocal
        cd ~/${LFTP_SRCDIR}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) install-strip install-man

        compress_binary lftp-${LFTP_VERSION}.txz
    else
        echo "Fail to download lftp"
    fi
else
    echo "Don't define variable for lftp"
fi