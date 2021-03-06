#!/bin/bash
#shellcheck disable=SC1090,SC2164

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source "${THIS_DIR}/../env.sh"

if [[ -n ${IPERF3_VERSION} && -n ${IPERF3_URL} && -n ${IPERF3_SRCDIR} ]]; then
    prepare_build "iperf3"

    if [ -d $HOME/${IPERF3_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${IPERF3_SRCDIR}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j "$(nproc)" install-strip

        compress_binary iperf-${IPERF3_VERSION} /usr/local/bin/iperf3
    else
        echo "Fail to download iperf"
    fi
else
    echo "Don't define variable iperf"
fi
