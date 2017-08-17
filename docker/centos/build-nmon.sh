#!/bin/bash

yum install -y -q ncurses-devel

FILENAME=lmon16g.c

curl -L https://sourceforge.net/projects/nmon/files/${FILENAME}/download -o lmon.c
curl -L https://sourceforge.net/projects/nmon/files/makefile/download -o Makefile

releasever=$(python -c 'import yum; yb = yum.YumBase(); print yb.conf.yumvar["releasever"]' | tail -n 1)

if [ $releasever = "7" ]; then
    make nmon_x86_rhel70
    mkdir -p /usr/local/bin/
    cp -pr nmon_x86_rhel70 /usr/local/bin/nmon
else
    make nmon_x86_rhel6
    mkdir -p /usr/local/bin/
    cp -pr nmon_x86_rhel6 /usr/local/bin/nmon
fi