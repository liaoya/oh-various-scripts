#!/bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n ${PROTOBUF_VERSION} && -n ${PROTOBUF_URL} && -n ${PROTOBUF_SRCDIR} ]]; then
    prepare_build "PROTOBUF"

    if [ -d $HOME/${PROTOBUF_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${PROTOBUF_SRCDIR}
        ./autogen.sh
        ./configure -q
        make -s -j $(nproc) install-strip

        compress_binary protobuf-${PROTOBUF_VERSION}.txz /usr/local/bin/protoc
    else
        echo "Fail to download protobuf"
    fi
else
    echo "Don't define variable for protobuf"
fi
