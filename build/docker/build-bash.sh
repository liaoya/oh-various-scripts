#!/bin/bash
#shellcheck disable=SC1090,SC2164

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source "${THIS_DIR}/../env.sh"

if [[ -n ${BASH_VERSION} && -n ${BASH_URL} && -n ${BASH_SRCDIR} ]]; then
    prepare_build "bash"

    if [ -d $HOME/${BASH_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${BASH_SRCDIR}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j "$(nproc)" install-strip

        compress_binary bash-${BASH_VERSION} /usr/local/bin/bash
        clear_usrlocal
    else
        echo "Fail to download bash"
    fi
else
    echo "Don't define variable for bash"
fi
