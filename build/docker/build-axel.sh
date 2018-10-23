#!/bin/bash

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source "${THIS_DIR}/../env.sh"

if [[ -n $AXEL_VERSION && -n $AXEL_URL && -n $AXEL_SRCDIR ]]; then
    prepare_build "axel"

    if [ -d $HOME/$AXEL_SRCDIR ]; then
        clear_usrlocal
        cd $HOME/$AXEL_SRCDIR
        ./autogen.sh
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc)
        make -s install-strip

        compress_binary axel-${AXEL_VERSION} /usr/local/bin/axel
    else
        echo "Fail to download silver searcher"
    fi
else
    echo "Don't define variable for silver searcher"
fi
