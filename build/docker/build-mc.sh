#!/bin/bash
#shellcheck disable=SC1090,SC2164

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source "${THIS_DIR}/../env.sh"

if [[ -n ${MC_VERSION} && -n ${MC_URL} && -n ${MC_SRCDIR} ]]; then
    prepare_build "mc"

    if [ -d $HOME/${MC_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${MC_SRCDIR}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j "$(nproc)" install-strip

        compress_binary mc-${MC_VERSION} /usr/local/bin/mc
    else
        echo "Fail to download mc"
    fi
else
    echo "Don't define variable for mc"
fi
