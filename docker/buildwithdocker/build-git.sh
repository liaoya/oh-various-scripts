#!/bin/sh

yum install -y -q curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel asciidoc xmlto docbook2X
ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi
export VERSION=2.12.0
cd ~
curl -L https://www.kernel.org/pub/software/scm/git/git-${VERSION}.tar.xz | tar -xJ
cd git-${VERSION}
make configure
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nprocs) all info
make strip
make install
cd ~
tar -Jcf git-${VERSION}.txz -C /usr/local .
