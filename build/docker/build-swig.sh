#!/bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n ${SWIG_VERSION} && -n ${SWIG_URL} && -n ${SWIG_SRCDIR} ]]; then
    prepare_build "swig"

    if [ -d $HOME/${SWIG_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${SWIG_SRCDIR}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc)
        make -s install
        for item in $(ls -1 /usr/local/bin/*swig*); do file $item | grep -q -s "not stripped" && strip -s $item; done

        compress_binary swig-${SWIG_VERSION} /usr/local/bin/swig
    else
        echo "Fail to download swig"
    fi
else
    echo "Don't define variable for swig"
fi
