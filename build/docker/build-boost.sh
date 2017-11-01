#!/bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n ${BOOST_VERSION} && -n ${BOOST_URL} && -n ${BOOST_SRCDIR} ]]; then
    prepare_build "BOOST"

    if [ -d ~/${BOOST_SRCDIR} ]; then
        clear_usrlocal
        cd ~/${BOOST_SRCDIR}
        ./bootstrap.sh
        ./b2 -j $(nproc) toolset=gcc cxxflags="-std=c++11" stage
        ./b2 -j $(nproc) toolset=gcc cxxflags="-std=c++11" install

        compress_binary boost-${BOOST_VERSION}.txz
    else
        echo "Fail to download boost"
    fi
else
    echo "Don't define variable for boost"
fi
