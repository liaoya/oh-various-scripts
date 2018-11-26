#!/bin/bash
#shellcheck disable=SC1090,SC2164

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source "${THIS_DIR}/../env.sh"

if [[ -n ${AG_VERSION} && -n ${AG_URL} && -n ${AG_SRCDIR} ]]; then
    prepare_build "ag"

    if [ -d $HOME/${AG_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${AG_SRCDIR}
        ./autogen.sh
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j "$(nproc)" install-strip

        compress_binary ag-${AG_VERSION} /usr/local/bin/ag
    else
        echo "Fail to download silver searcher"
    fi
else
    echo "Don't define variable for silver searcher"
fi
