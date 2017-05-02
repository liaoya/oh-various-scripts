#!/bin/sh

# The installation has problem

dnf install -y -q mingw64-gcc-c++

VERSION=3.2.0
curl -L https://github.com/google/protobuf/archive/v${VERSION}.tar.gz | tar -xz -C ~
cd ~/protobuf-${VERSION}
./autogen.sh
#./configure -q --build=x86_64-redhat-linux --host=x86_64-redhat-linux --target=x86_64-redhat-linux
./configure -q
make -j $(nproc)
make install-strip
make distclean
./configure --host=x86_64-w64-mingw32 --build=x86_64-redhat-linux-gnu \
--prefix=/usr/local/mingw --exec-prefix=/usr/local/mingw --bindir=/usr/local/mingw/bin --sbindir=/usr/local/mingw/sbin \
--sysconfdir=/usr/local/mingw/etc --datadir=/usr/local/mingw/share --includedir=/usr/local/mingw/include --libdir=/usr/local/mingw/lib \
--libexecdir=/usr/local/mingw/libexec --localstatedir=/usr/local/mingw/var --sharedstatedir=/usr/local/mingw/com \
--mandir=/usr/local/mingw/share/man --infodir=/usr/local/mingw/share/info --with-protoc=/usr/local/bin/protoc
#grep -RIl sys-root * | grep -v config.log | xargs sed -i "s/\/usr\/x86_64-w64-mingw32\/sys-root/\usr\/local/g"
make -j $(nproc)
make install-strip
cp -pr /usr/x86_64-w64-mingw32/sys-root/mingw/bin/{libatomic-1.dll,libgcc_s_seh-1.dll,libssp-0.dll,libstdc++-6.dll,libwinpthread-1.dll} /usr/local/mingw/bin
