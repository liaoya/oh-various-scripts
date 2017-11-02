#!/bin/bash

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n ${GDB_VERSION} && -n ${GDB_URL} && -n ${GDB_SRCDIR} ]]; then
    prepare_build "GDB"

    if [ -d ~/${GDB_SRCDIR} ]; then
        clear_usrlocal
        mkdir ~/${GDB_SRCDIR}/build
        cd ~/${GDB_SRCDIR}/build
        sh ../configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc)
        make -s install
        for item in $(ls -1 /usr/local/bin/gdb*); do file $item | grep -q -s "not stripped" && strip -S $item; done

        # compress_binary gdb-${GDB_VERSION}.txz
    else
        echo "Fail to download gdb"
    fi
else
    echo "Don't define variable gdb"
fi
