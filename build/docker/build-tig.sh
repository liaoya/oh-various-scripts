#!/bin/bash
#shellcheck disable=SC1090,SC2164

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source "${THIS_DIR}/../env.sh"

export TIG_VERSION=$(curl -s "https://api.github.com/repos/jonas/tig/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
export TIG_URL=https://github.com/jonas/tig/archive/${TIG_VERSION}.tar.gz
export TIG_SRCDIR=tig-${TIG_VERSION}

check_uptodate ${TIG_VERSION}
if [[ -n $TIG_VERSION && -n $TIG_URL && -n $TIG_SRCDIR ]]; then
    prepare_build "tig"

    if [ -d $HOME/$TIG_SRCDIR ]; then
        clear_usrlocal
        cd $HOME/$TIG_SRCDIR
        ./autogen.sh
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j "$(nproc)" all
        make -s -j "$(nproc)" strip
        make -s -j "$(nproc)" install
        compress_binary ${TIG_VERSION} /usr/local/bin/tig
    else
        echo "Fail to download tig"
    fi
else
    echo "Don't define variable for tig"
fi
