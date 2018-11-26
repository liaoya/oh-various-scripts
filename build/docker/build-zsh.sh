#!/bin/bash
#shellcheck disable=SC1090,SC2164

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source "${THIS_DIR}/../env.sh"

if [[ -n ${ZSH_VERSION} && -n ${ZSH_URL} && -n ${ZSH_SRCDIR} ]]; then
    prepare_build "zsh"

    if [ -d $HOME/${ZSH_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${ZSH_SRCDIR}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j "$(nproc)" all
        make -s install-strip

        compress_binary zsh-${ZSH_VERSION} /usr/local/bin/zsh
    else
        echo "Fail to download zsh"
    fi
else
    echo "Don't define variable zsh"
fi
