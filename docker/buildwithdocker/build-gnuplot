#!/bin/bash

yum install -y -q atk-devel cairo-devel expat-devel gtk2-devel \
    libacl-devel libjpeg-turbo-devel libpng-devel libtiff-devel \
    pcre-devel pango-devel wxGTK-devel zlib-devel

VERSION=5.0.6
curl -L https://sourceforge.net/projects/gnuplot/files/gnuplot/${VERSION}/gnuplot-${VERSION}.tar.gz/download | tar -xz -C ~/
cd ~/gnuplot-${VERSION}
make -j $(nproc) install-strip