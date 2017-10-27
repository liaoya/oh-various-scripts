#!/bin/sh

dnf install -y -q mingw64-zlib.noarch mingw64-openssl.noarch mingw64-gnutls.noarch mingw64-c-ares.noarch

PROTOBUF_VERSION=3.3.0
curl -L https://github.com/google/protobuf/archive/v${PROTOBUF_VERSION}.tar.gz | tar -xz -C ~
cd ~/protobuf-${PROTOBUF_VERSION}
./autogen.sh
./configure -q
make -j $(nproc)
make install-strip
make distclean
./configure -q --host=x86_64-w64-mingw32 --build=x86_64-redhat-linux-gnu \
--prefix=/usr/local/mingw64 --exec-prefix=/usr/local/mingw64 --bindir=/usr/local/mingw64/bin --sbindir=/usr/local/mingw64/sbin \
--sysconfdir=/usr/local/mingw64/etc --datadir=/usr/local/mingw64/share --includedir=/usr/local/mingw64/include --libdir=/usr/local/mingw64/lib \
--libexecdir=/usr/local/mingw64/libexec --localstatedir=/usr/local/mingw64/var --sharedstatedir=/usr/local/mingw64/com \
--mandir=/usr/local/mingw64/share/man --infodir=/usr/local/mingw64/share/info --with-protoc=/usr/local/bin/protoc
make -j $(nproc) install-strip

GRPC_VERSION=1.3.2
curl -L https://github.com/grpc/grpc/archive/v${GRPC_VERSION}.tar.gz | tar -xz -C ~
cd ~/grpc-${GRPC_VERSION}
cd ~/grpc-${VERSION}/third_party/cares
CARES_VERSION=1.12.0
curl -L https://c-ares.haxx.se/download/c-ares-${CARES_VERSION}.tar.gz | tar -xz
[ -d c-ares-${CARES_VERSION} ] && mv c-ares-${CARES_VERSION}/* cares/
cd ~/grpc-${VERSION}/
export PKG_CONFIG_PATH=/usr/x86_64-w64-mingw32/sys-root/mingw/lib/pkgconfig:$PKG_CONFIG_PATH
make -j $(nproc)
make strip install