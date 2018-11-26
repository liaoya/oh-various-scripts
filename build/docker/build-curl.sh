#! /bin/sh
#shellcheck disable=SC1090,SC2164

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source "${THIS_DIR}/../env.sh"

if [[ -n $CURL_VERSION && -n $CURL_URL && -n $CURL_SRCDIR ]]; then
    prepare_build "curl"

    if [ -d $HOME/$CURL_SRCDIR ]; then
        clear_usrlocal
        cd $HOME/$CURL_SRCDIR
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j "$(nproc)" install-strip
        compress_binary curl-${CURL_VERSION} /usr/local/bin/curl
        clear_usrlocal
    else
        echo "Fail to download curl"
    fi
else
    echo "Don't define variable for curl"
fi
