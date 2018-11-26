#!/bin/bash
#shellcheck disable=SC1090,SC2164

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source "${THIS_DIR}/../env.sh"

if [[ -n ${HIGHLIGHT_VERSION} && -n ${HIGHLIGHT_URL} && -n ${HIGHLIGHT_SRCDIR} ]]; then
    prepare_build "highlight"

    if [ -d $HOME/${HIGHLIGHT_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${HIGHLIGHT_SRCDIR}
        sed -i "s/PREFIX = \/usr/PREFIX = \/usr\/local/g" makefile
        make -s -j $(nproc)
        strip src/highlight
        make install

        compress_binary highlight-${HIGHLIGHT_VERSION} /usr/local/bin/highlight
    else
        echo "Fail to download highlight"
    fi
else
    echo "Don't define variable highlight"
fi
