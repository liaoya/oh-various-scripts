#!/bin/sh

yum install -y -q zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel expat-devel

VERSION=3.6.1
curl -L https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz | tar -xz -C ~/

cd ~/Python-${VERSION}
./configure -q --enable-optimizations --enable-shared --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make
make altinstall
for item in $(ls -1 /usr/local/bin/python3*); do file $item | grep -q -s "not stripped" && strip $item; done 
for item in $(ls -1 /usr/local/lib/libpython3*); do file $item | grep -q -s "not stripped" && strip $item; done 
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
/usr/local/bin/pip3.6 install -U virtualenv
mv /usr/local/bin/virtualenv /usr/local/bin/virtualenv-3.6
