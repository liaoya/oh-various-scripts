#!/bin/bash

# https://github.com/docker/docker/issues/22801
# echo 0 > /proc/sys/kernel/randomize_va_space

yum install -q -y ncurses-devel libacl-devel

VERSION=25.3
curl -L http://ftpmirror.gnu.org/gnu/emacs/emacs-${VERSION}.tar.xz | tar -Jx -C ~/

cd ~/emacs-${VERSION}
./configure -q --with-x-toolkit=no --without-x --without-all --build=x86_64-redhat-linux --host=x86_64-redhat-linux --target=x86_64-redhat-linux
make -s -j $(nprocs) all
make -s -j $(nprocs) install-strip
