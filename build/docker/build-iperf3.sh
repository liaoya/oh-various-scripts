#!/bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n ${IPERF3_VERSION} && -n ${IPERF3_URL} && -n ${IPERF3_SRCDIR} ]]; then
    prepare_build "IPERF3"

    if [ -d ~/${IPERF3_SRCDIR} ]; then
        clear_usrlocal
        cd ~/${IPERF3_SRCDIR}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) install-strip

        compress_binary iperf-${IPERF3_VERSION}.txz
    else
        echo "Fail to download iperf"
    fi
else
    echo "Don't define variable iperf"
fi
