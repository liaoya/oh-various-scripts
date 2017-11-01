#!/bin/sh

sudo apt-get update -qq

sudo apt-get install -qy build-essential fakeroot git graphviz autoconf automake bzip2 \
    debhelper dh-autoreconf libssl-dev libtool openssl procps \
    python-all python-qt4 python-twisted-conch python-zopeinterface python-six libcap-ng-dev

OVS_URL=http://openvswitch.org/releases/openvswitch-2.8.0.tar.gz
[ -d ~/$(basename $OVS_URL .tar.gz) ] && rm -fr ~/$(basename $OVS_URL .tar.gz)
cOVS_URL -s -L $OVS_URL | tar -xz -C ~/
cd ~/$(basename $OVS_URL .tar.gz)
dpkg-checkbuilddeps
DEB_BUILD_OPTIONS="parallel=${NUM_CPUS} nocheck" fakeroot debian/rules binary
cp -pr ../*.deb /vagrant

sudo apt-get install -qy module-assistant
(sudo dpkg -i ~/openvswitch-datapath-source_2*_all.deb && \
    sudo m-a --text-mode prepare && \
    sudo m-a --text-mode build openvswitch-datapath) ||
    { echo >&2 "Unable to build kernel modules"; exit 1; }
cp -v /usr/src/openvswitch-datapath-module-*.deb /vagrant
