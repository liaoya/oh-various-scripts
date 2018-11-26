#!/bin/bash
#shellcheck disable=SC1090,SC2164

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source "${THIS_DIR}/../env.sh"

if [[ -n ${LFTP_VERSION} && -n ${LFTP_URL} && -n ${LFTP_SRCDIR} ]]; then
    prepare_build "lftp"

    if [ -d $HOME/${LFTP_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${LFTP_SRCDIR}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j "$(nproc)" install-strip install-man

        compress_binary lftp-${LFTP_VERSION} /usr/local/bin/lftp
    else
        echo "Fail to download lftp"
    fi
else
    echo "Don't define variable for lftp"
fi
