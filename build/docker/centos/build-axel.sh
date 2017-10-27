#!/bin/bash

yum install -y -q openssl-devel gettext-devel

AXEL_VERSION=2.14.1
curl -L https://github.com/eribertomota/axel/archive/${AXEL_VERSION}.tar.gz | tar -zx -C ~/
cd axel-${AXEL_VERSION}
./autogen.sh
./configure
make -j $(nproc)
make install-strip
