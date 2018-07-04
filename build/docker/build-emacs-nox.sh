#!/bin/bash

# https://stackoverflow.com/questions/37544423/how-to-build-emacs-from-source-in-docker-hub-gap-between-bss-and-heap
# https://github.com/docker/docker/issues/22801
# echo 0 > /proc/sys/kernel/randomize_va_space
# So build in vm

[[ -f ../env.sh ]] && source ../env.sh

if [[ -n ${EMACS_VERSION} && -n ${EMACS_URL} && -n ${EMACS_SRCDIR} ]]; then
    prepare_build "emacs"

    if [ -d $HOME/${EMACS_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${EMACS_SRCDIR}
        ./configure -q --with-x-toolkit=no --without-x --without-all --build=x86_64-redhat-linux --host=x86_64-redhat-linux --target=x86_64-redhat-linux
        make -s -j $(nprocs) all
        make -s install-strip

        compress_binary emacs-nox-${EMACS_VERSION} /usr/local/bin/emacs
    else
        echo "Fail to download emacs"
    fi
else
    echo "Don't define variable emacs"
fi

