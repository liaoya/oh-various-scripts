#!/bin/sh

[[ -f ../env.sh ]] && source ../env.sh

GFLAGS_VERSION=$(curl -s "https://api.github.com/repos/gflags/gflags/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
export GFLAGS_VERSION=${GFLAGS_VERSION:1}
export GFLAGS_URL=https://github.com/gflags/gflags/archive/v${GFLAGS_VERSION}.tar.gz
export GFLAGS_ARCHIVE_NAME=gflags-${GFLAGS_VERSION}.tar.gz
export GFLAGS_SRCDIR=gflags-${GFLAGS_VERSION}

if [[ -n ${GFLAGS_VERSION} && -n ${GFLAGS_URL} && -n ${GFLAGS_SRCDIR} ]]; then
    prepare_build "gflags"

    if [ -d $HOME/${GFLAGS_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${GFLAGS_SRCDIR}
        mkdir build && cd build
        cmake3 -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local ..
        make -s install/strip

        compress_binary gflags-${GFLAGS_VERSION} /usr/local/include/gflags/gflags.h
    else
        echo "Fail to download gflags"
    fi
else
    echo "Don't define variable gflags"
fi
