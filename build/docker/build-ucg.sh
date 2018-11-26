#!/bin/bash
#shellcheck disable=SC1090,SC2155,SC2164

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source "${THIS_DIR}/../env.sh"

export UCG_VERSION=$(curl -s "https://api.github.com/repos/gvansickle/ucg/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
export UCG_URL=https://github.com/gvansickle/ucg/releases/download/${UCG_VERSION}/universalcodegrep-${UCG_VERSION}.tar.gz
export UCG_SRCDIR=universalcodegrep-${UCG_VERSION}

if [[ -n $UCG_VERSION && -n $UCG_URL && -n $UCG_SRCDIR ]]; then
    prepare_build "ucg"

    if [ -d $HOME/$UCG_SRCDIR ]; then
        clear_usrlocal
        cd $HOME/$UCG_SRCDIR
        ./autogen.sh
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j "$(nproc)" install-strip

        compress_binary ucg-${UCG_VERSION} /usr/local/bin/ucg
    else
        echo "Fail to download UniversalCodeGrep"
    fi
else
    echo "Don't define variable for UniversalCodeGrep"
fi
