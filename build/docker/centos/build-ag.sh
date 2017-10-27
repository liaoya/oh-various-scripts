#!/bin/sh

yum install -y -q pcre-devel xz-devel zlib-devel

AG_VERSION=2.1.0
curl -L https://github.com/ggreer/the_silver_searcher/archive/${AG_VERSION}.tar.gz | tar -xz -C ~/
cd ~/the_silver_searcher-${AG_VERSION}
./autogen.sh
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) install-strip
