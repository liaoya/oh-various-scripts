#!/bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n $GRPC_VERSION && -n $GRPC_URL && -n $GRPC_SRCDIR ]]; then
    prepare_build "GRPC"
    prepare_build "GRPC_PROTOBUF"
    prepare_build "GRPC_CARES"
    prepare_build "GRPC_JAVA"

    clear_usrlocal

    if [ -d ~/$GRPC_PROTOBUF_SRCDIR ]; then
        cd ~/$GRPC_PROTOBUF_SRCDIR
        ./autogen.sh
        ./configure -q
        make -s -j $(nproc) install-strip

        [ -d ~/${GRPC_CARES_SRCDIR} ] && cp -fpr ~/${GRPC_CARES_SRCDIR}/* ~/${GRPC_SRCDIR}/third_party/cares/cares/
        cd ~/${GRPC_SRCDIR}
        make -s -j $(nproc)
        make -s -j $(nproc) strip install
        for item in $(ls -1 /usr/local/bin/grpc*plugin); do file $item | grep -q -s "not stripped" && strip -S $item; done

        cd ~/${GRPC_JAVA_SRCDIR}
        g++ -std=c++11 -I/usr/local/include -pthread -L/usr/local/lib -lprotoc -lprotobuf -lpthread -ldl -s -o /usr/local/bin/grpc_java_plugin *.cpp

    else
        echo "Fail to download protobuf"
    fi
else
    echo "Don't define variable for grpc and protubuf"
fi

# git submodule update --recursive --remotecd
# make run_dep_checks
