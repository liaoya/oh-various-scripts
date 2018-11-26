#!/bin/bash
#shellcheck disable=SC1090,SC2164

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source "${THIS_DIR}/../env.sh"

if [[ -n ${SSHPASS_VERSION} && -n ${SSHPASS_URL} && -n ${SSHPASS_SRCDIR} ]]; then
    prepare_build "sshpass"

    if [ -d $HOME/${SSHPASS_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${SSHPASS_SRCDIR}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j "$(nproc)" install-strip

        compress_binary sshpass-${SSHPASS_VERSION} /usr/local/bin/sshpass
    else
        echo "Fail to download sshpass"
    fi
else
    echo "Don't define variable for sshpass"
fi
