#!/bin/sh

#!/bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n $SOURCE_HIGHLIGHT_VERSION && -n $SOURCE_HIGHLIGHT_URL && -n $SOURCE_HIGHLIGHT_SRCDIR ]]; then
    prepare_build "SOURCE_HIGHLIGHT"

    if [ -d ~/$SOURCE_HIGHLIGHT_SRCDIR ]; then
        clear_usrlocal
        cd ~/$SOURCE_HIGHLIGHT_SRCDIR
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) install-strip

        compress_binary source-highlight-${SOURCE_HIGHLIGHT_VERSION}.txz
    else
        echo "Fail to download source hightlight"
    fi
else
    echo "Don't define variable for source hightlight"
fi
