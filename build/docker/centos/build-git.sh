#!/bin/sh

yum install -y -q curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel asciidoc xmlto docbook2X
[ -x /usr/bin/db2x_docbook2texi ] && ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi

VERSION=2.14.2
curl -L https://www.kernel.org/pub/software/scm/git/git-${VERSION}.tar.xz | tar -xJ -C ~
cd ~/git-${VERSION}
make configure
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) all info
make -j $(nproc) strip
make -j $(nproc) install install-man
