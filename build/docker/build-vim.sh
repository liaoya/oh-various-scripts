#!/bin/bash
#shellcheck disable=SC1090,SC2164

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source "${THIS_DIR}/../env.sh"

if [[ -n $VIM_VERSION && -n $VIM_URL && -n $VIM_SRCDIR ]]; then
    prepare_build "vim"

    if [ -d $HOME/$VIM_SRCDIR ]; then
        clear_usrlocal
        cd "$HOME/$VIM_SRCDIR"
        ./configure -q --with-features=huge --enable-pythoninterp --enable-cscope --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j "$(nproc)" install

        compress_binary vim-huge-${VIM_VERSION} /usr/local/bin/vim
    else
        echo "Fail to download vim-huge"
    fi
else
    echo "Don't define variable for vim-huge"
fi
