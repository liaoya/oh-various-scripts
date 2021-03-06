#!/bin/bash
#shellcheck disable=SC1090

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source ${THIS_DIR}/../env.sh

if [[ -n $GIT_VERSION && -n $GIT_URL && -n $GIT_SRCDIR ]]; then
    prepare_build "git"

    [[ -f /etc/redhat-release && -x /usr/bin/db2x_docbook2texi && ! -h /usr/bin/docbook2x-texi ]] && ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi

    if [ -d $HOME/$GIT_SRCDIR ]; then
        clear_usrlocal
        cd $HOME/$GIT_SRCDIR
        make configure
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j "$(nproc)" all info
        make -s -j "$(nproc)" strip
        make -s -j "$(nproc)" install install-man

        compress_binary git-${GIT_VERSION} /usr/local/bin/git
    else
        echo "Fail to download GIT"
    fi
else
    echo "Don't define variable for git"
fi
