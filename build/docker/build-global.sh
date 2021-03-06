#!/bin/bash
#shellcheck disable=SC1090,SC2164

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source "${THIS_DIR}/../env.sh"

if [[ -n ${GLOBAL_VERSION} && -n ${GLOBAL_URL} && -n ${GLOBAL_SRCDIR} ]]; then
    prepare_build "global"

    if [ -d $HOME/${GLOBAL_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${GLOBAL_SRCDIR}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j "$(nproc)" all
        make -s install-strip

        compress_binary global-${GLOBAL_VERSION} /usr/local/bin/global
    else
        echo "Fail to download global"
    fi
else
    echo "Don't define variable global"
fi
