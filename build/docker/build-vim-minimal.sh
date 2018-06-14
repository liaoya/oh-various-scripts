#!/bin/sh

[[ -f ../env.sh ]] && source ../env.sh

if [[ -n $VIM_VERSION && -n $VIM_URL && -n $VIM_SRCDIR ]]; then
    prepare_build "vim"

    if [ -d $HOME/$VIM_SRCDIR ]; then
        clear_usrlocal
        cd $HOME/$VIM_SRCDIR
        ./configure -q --with-features=tiny --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) install

        compress_binary vim-minimal-${VIM_VERSION} /usr/local/bin/vim
    else
        echo "Fail to download vim-minimal"
    fi
else
    echo "Don't define variable for vim-minimal"
fi
