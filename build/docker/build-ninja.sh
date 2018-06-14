#!/bin/sh

# https://github.com/ninja-build/ninja provide binary release

[[ -f ../env.sh ]] && source ../env.sh

NINJA_VERSION=$(curl -s "https://api.github.com/repos/ninja-build/ninja/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
export NINJA_VERSION=${NINJA_VERSION:1}
export NINJA_URL=https://github.com/ninja-build/ninja/archive/v${NINJA_VERSION}.tar.gz
export NINJA_ARCHIVE_NAME=ninja-${NINJA_VERSION}.tar.gz
export NINJA_SRCDIR=ninja-${NINJA_VERSION}

if [[ -n ${NINJA_VERSION} && -n ${NINJA_URL} && -n ${NINJA_SRCDIR} ]]; then
    prepare_build "ninja"

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
