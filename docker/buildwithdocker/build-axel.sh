#!/bin/bash

yum install -y -q openssl-devel gettext-devel

VERSION=2.12
curl -L https://github.com/eribertomota/axel/archive/${VERSION}.tar.gz | tar -zx -C ~/
cd axel-${VERSION}
./autogen.sh
./configure
make -j $(nproc)
make install-strip