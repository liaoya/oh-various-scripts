#!/bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

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
