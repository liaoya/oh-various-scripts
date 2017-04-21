#!/bin/sh

yum install -y -q zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel expat-devel

VERSION=3.6.1
curl -L https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz | tar -xz -C ~/

cd Python-${VERSION}
./configure --enable-optimizations --enable-shared
make
make altinstall
for item in $(ls -1 /usr/local/bin/python3*); do [ -x $item ] && strip $item; done
/usr/local/bin/pip3.6 install -U virtualenv
mv /usr/local/bin/virtualenv /usr/local/bin/virtualenv-3.6
