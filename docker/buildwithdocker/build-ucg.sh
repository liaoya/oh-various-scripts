#!/bin/sh

# pcre2 is required to run

yum install -y -q pcre2-devel pcre-devel jemalloc-devel

VERSION=0.3.3
curl -L https://github.com/gvansickle/ucg/releases/download/${VERSION}/universalcodegrep-${VERSION}.tar.gz | tar -xz -C ~/
cd ~/universalcodegrep-${VERSION}
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) install-strip