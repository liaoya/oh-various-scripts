#!/bin/sh

yum install -y -q pcre2-devel pcre-devel xz-devel zlib-devel

VERSION=1.0.2
curl -L https://github.com/ggreer/the_silver_searcher/archive/${VERSION}.tar.gz | tar -xz -C ~/
cd the_silver_searcher-${VERSION}
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) install-strip