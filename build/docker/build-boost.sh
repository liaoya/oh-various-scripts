#!/bin/sh

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source "${THIS_DIR}/../env.sh"

if [[ -n ${BOOST_VERSION} && -n ${BOOST_URL} && -n ${BOOST_SRCDIR} ]]; then
    prepare_build "boost"

    if [ -d $HOME/${BOOST_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${BOOST_SRCDIR}
        ./bootstrap.sh
        ./b2 -j $(nproc) toolset=gcc cxxflags="-std=c++11" stage
        ./b2 -j $(nproc) toolset=gcc cxxflags="-std=c++11" install

        compress_binary boost-${BOOST_VERSION} /usr/local/include/boost/version.hpp
    else
        echo "Fail to download boost"
    fi
else
    echo "Don't define variable for boost"
fi
