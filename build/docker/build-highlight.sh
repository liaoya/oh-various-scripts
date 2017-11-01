#!/bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n ${HIGHLIGHT_VERSION} && -n ${HIGHLIGHT_URL} && -n ${HIGHLIGHT_SRCDIR} ]]; then
    prepare_build "HIGHLIGHT"

    if [ -d ~/${HIGHLIGHT_SRCDIR} ]; then
        clear_usrlocal
        cd ~/${HIGHLIGHT_SRCDIR}
        sed -i "s/PREFIX = \/usr/PREFIX = \/usr\/local/g" makefile
        make -j $(nproc)
        strip src/highlight
        make install

        compress_binary highligt-${HIGHLIGHT_VERSION}.txz
    else
        echo "Fail to download highligt"
    fi
else
    echo "Don't define variable highligt"
fi
