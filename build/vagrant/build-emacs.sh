#!/bin/bash

# https://github.com/docker/docker/issues/22801
# echo 0 > /proc/sys/kernel/randomize_va_space
# So build in vm

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n ${EMACS_VERSION} && -n ${EMACS_URL} && -n ${EMACS_SRCDIR} ]]; then
    prepare_build "EMACS"

    if [ -d $HOME/${EMACS_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${EMACS_SRCDIR}
        ./configure -q --with-x-toolkit=gtk3 --build=x86_64-redhat-linux --host=x86_64-redhat-linux --target=x86_64-redhat-linux
        make -s -j $(nprocs) all
        make -s install-strip

        compress_binary emacs-${EMACS_VERSION}.txz /usr/local/bin/emacs
    else
        echo "Fail to download emacs"
    fi
else
    echo "Don't define variable emacs"
fi
