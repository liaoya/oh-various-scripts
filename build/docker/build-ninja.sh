#!/bin/sh

# https://github.com/ninja-build/ninja provide binary release

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n ${NINJA_VERSION} && -n ${NINJA_URL} && -n ${NINJA_SRCDIR} ]]; then
    prepare_build "NINJA"

    if [ -d $HOME/${NINJA_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${NINJA_SRCDIR}
        ./configure.py --bootstrap
        strip ninja
        mkdir -p /usr/local/bin
        cp -pr ninja /usr/local/bin

        compress_binary ninja-${NINJA_VERSION} /usr/local/bin/ninja
    else
        echo "Fail to download ninja"
    fi
else
    echo "Don't define variable ninja"
fi
