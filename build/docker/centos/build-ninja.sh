#!/bin/sh

# https://github.com/ninja-build/ninja provide binary release

yum install -y -q re2c

VERSION=1.8.2
curl -L https://github.com/ninja-build/ninja/archive/v${VERSION}.tar.gz | tar -xz -C ~
cd ~/ninja-${VERSION}
./configure.py --bootstrap
strip ninja
mkdir -p /usr/local/bin
cp -pr ninja /usr/local/bin
