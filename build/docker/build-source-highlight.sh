#!/bin/bash
#shellcheck disable=SC1090

[[ -f ../env.sh ]] && source ../env.sh

if [[ -n $SOURCE_HIGHLIGHT_VERSION && -n $SOURCE_HIGHLIGHT_URL && -n $SOURCE_HIGHLIGHT_SRCDIR ]]; then
    prepare_build "SOURCE_HIGHLIGHT"

    if [ -d $HOME/$SOURCE_HIGHLIGHT_SRCDIR ]; then
        clear_usrlocal
        cd $HOME/$SOURCE_HIGHLIGHT_SRCDIR
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) install-strip

        compress_binary source-highlight-${SOURCE_HIGHLIGHT_VERSION} /usr/local/bin/source-highlight
    else
        echo "Fail to download source hightlight"
    fi
else
    echo "Don't define variable for source hightlight"
fi
