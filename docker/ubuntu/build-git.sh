#!/bin/sh

rm -fr /usr/local/*

apt-get -qq -y install dh-autoreconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev docbook2x asciidoc-base

VERSION=2.14.1
curl -L https://www.kernel.org/pub/software/scm/git/git-${VERSION}.tar.xz | tar -xJ -C ~
cd ~/git-${VERSION}
make configure
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) all info
make -j $(nproc) strip
make -j $(nproc) install install-man

tar -C /usr/local -cf ~/output/git-$VERSION.txz .