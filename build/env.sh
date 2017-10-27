#!/bin/bash

export CENTOS_DEPS="autoconf automake libtool gcc gcc-c++ make file which pxz pigz lbzip2 unzip bzip2 xz lzip openssh-clients"
export UBUNTU_DEPS="curl openssh-client sshpass build-essential fakeroot"

AG_VERSION=2.1.0
AG_URL=https://github.com/ggreer/the_silver_searcher/archive/${AG_VERSION}.tar.gz
AG_SRCDIR=the_silver_searcher-${AG_VERSION}
AG_CENTOS_DEPS="$CENTOS_DEPS pcre-devel xz-devel zlib-devel"

AXEL_VERSION=2.14.1
AXEL_URL=https://github.com/eribertomota/axel/archive/${AXEL_VERSION}.tar.gz
AXEL_SRCDIR=axel-${AXEL_VERSION}

export GIT_VERSION=2.14.3
export GIT_URL=https://www.kernel.org/pub/software/scm/git/git-${GIT_VERSION}.tar.xz
export GIT_SRCDIR=git-${GIT_VERSION}
export GIT_UBUNTU_DEPS="$UBUNTU_DEPS dh-autoreconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev docbook2x asciidoc"

export OVS_VERSION=2.8.1
export OVS_URL=http://openvswitch.org/releases/openvswitch-${OVS_VERSION}.tar.gz

export TIG_VERSION=2.2.2
export TIG_URL=https://github.com/jonas/tig/releases/download/tig-${VERSION}/tig-${VERSION}.tar.gz

clear_usrlocal() {
    rm -fr /usr/local/*
}

compress_binary() {
    tar -C /usr/local -cf 
}

download_source() {
    (cd ~; [ -f $(basename "$1") ] || curl -L -O $1)
}

install_centos_deps() {
    
}

install_fedora_deps() {

}

install_oraclelinux_deps() {

}

install_ubuntu_deps() {

}

install_deps() {
    [ -f /etc/centos-release ] && install_centos_deps $1
    [ -f /etc/fedora-relase ] && install_fedora_deps $1
    [ -f /etc/oracle-release ] && install_oraclelinux_deps $1
    [ -f /etc/lsb-release ] && grep -w -s -q Ubuntu /etc/lsb-release && install_ubuntu_deps $1
}

uncompress_source() {
    (cd ~; [ -d "$2" ] && rm -fr "$2"; tar -C ~ -xf "$1")
}
