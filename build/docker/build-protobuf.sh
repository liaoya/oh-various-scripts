#!/bin/bash
#shellcheck disable=SC1090,SC2164

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source "${THIS_DIR}/../env.sh"

PROTOBUF_VERSION=$(curl -s "https://api.github.com/repos/google/protobuf/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
export PROTOBUF_VERSION=${PROTOBUF_VERSION:1}
export PROTOBUF_URL=https://github.com/google/protobuf/archive/v${PROTOBUF_VERSION}.tar.gz

if [[ -n ${PROTOBUF_VERSION} && -n ${PROTOBUF_URL} && -n ${PROTOBUF_SRCDIR} ]]; then
    prepare_build "protobuf"

    if [ -d $HOME/${PROTOBUF_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${PROTOBUF_SRCDIR}
        ./autogen.sh
        ./configure -q
        make -s -j "$(nproc)" install-strip

        compress_binary protobuf-${PROTOBUF_VERSION} /usr/local/bin/protoc
    else
        echo "Fail to download protobuf"
    fi
else
    echo "Don't define variable for protobuf"
fi
