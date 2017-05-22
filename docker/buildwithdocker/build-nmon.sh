#!/bin/bash

yum install -y -q ncurses-devel

FILENAME=lmon16g.c

curl -L https://sourceforge.net/projects/nmon/files/${FILENAME}/download -o lmon.c
curl -L https://sourceforge.net/projects/nmon/files/makefile/download -o Makefile
make nmon_x86_rhel72
mkdir -p /usr/local/bin/
cp -pr nmon_x86_rhel72 /usr/local/bin/
ln -s /usr/local/bin/nmon_x86_rhel72 /usr/local/bin/nmon