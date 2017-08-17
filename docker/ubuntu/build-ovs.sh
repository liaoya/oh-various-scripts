#!/bin/sh

apt update
apt install -y build-essential fakeroot git graphviz autoconf automake bzip2 \
    debhelper dh-autoreconf libssl-dev libtool openssl procps \
    python-all python-qt4 python-twisted-conch python-zopeinterface python-six

cd ~
URL=http://openvswitch.org/releases/openvswitch-2.7.2.tar.gz
curl -L $URL | tar -xz -C ~/
cd ~/$(basename $URL)
dpkg-checkbuilddeps
DEB_BUILD_OPTIONS="parallel=${NUM_CPUS} nocheck" fakeroot debian/rules binary