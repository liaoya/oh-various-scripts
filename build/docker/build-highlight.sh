#!/bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n ${HIGHLIGHT_VERSION} && -n ${HIGHLIGHT_URL} && -n ${HIGHLIGHT_SRCDIR} ]]; then
    prepare_build "HIGHLIGHT"

    if [ -d $HOME/${HIGHLIGHT_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${HIGHLIGHT_SRCDIR}
        sed -i "s/PREFIX = \/usr/PREFIX = \/usr\/local/g" makefile
        make -s -j $(nproc)
        strip src/highlight
        make install

        compress_binary highlight-${HIGHLIGHT_VERSION} /usr/local/bin/highlight
    else
        echo "Fail to download highlight"
    fi
else
    echo "Don't define variable highlight"
fi
