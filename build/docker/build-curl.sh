#! /bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n $CURL_VERSION && $CURL_URL && $CURL_SRCDIR ]]; then
    prepare_build "CURL"

    if [ -d ~/$CURL_SRCDIR ]; then
        clear_usrlocal
        cd ~/$CURL_SRCDIR
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) install-strip
        compress_binary curl-${CURL_VERSION}.txz
        clear_usrlocal
    else
        echo "Fail to download curl"
    fi
else
    echo "Don't define variable for curl"
fi
