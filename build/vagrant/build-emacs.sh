#!/bin/bash

# https://github.com/docker/docker/issues/22801
# echo 0 > /proc/sys/kernel/randomize_va_space

yum install -q -y GConf2-devel dbus-devel giflib-devel gnutls-devel gtk3-devel gpm-devel \
    libX11-devel libXpm-devel libacl-devel libjpeg-turbo-devel libotf-devel librsvg2-devel libtiff-devel \
    libselinux-devel libxml2-devel m17n-lib-devel ncurses-devel \
    openjpeg-devel openjpeg2-devel turbojpeg-devel wxGTK-devel wxGTK3-devel

VERSION=25.3
curl -L http://ftpmirror.gnu.org/gnu/emacs/emacs-${VERSION}.tar.xz | tar -Jx -C ~/
cd ~/emacs-${VERSION}
./configure -q --with-x-toolkit=gtk3 --build=x86_64-redhat-linux --host=x86_64-redhat-linux --target=x86_64-redhat-linux
make -s -j $(nprocs) all
make install-strip

