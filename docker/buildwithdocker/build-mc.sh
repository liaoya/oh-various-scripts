#!/bin/sh

yum install -y -q ncurses-devel glib2-devel slang-devel gpm-devel libssh2-devel openssl-libs-devel zlib-devel krb5-libs-devel libcom_err-devel keyutils-libs-devel pcre-devel libselinux-devel

export VERSION=4.8.19
curl -L http://ftp.midnight-commander.org/mc-${VERSION}.tar.xz | tar -Jx -C ~/
cd mc-${VERSION}
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) install-strip