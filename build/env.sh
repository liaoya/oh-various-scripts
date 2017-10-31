#!/bin/bash

export CENTOS_DEPS="autoconf automake libtool gcc gcc-c++ make file which pxz pigz lbzip2 unzip bzip2 xz lzip openssh-clients"
export UBUNTU_DEPS="curl openssh-client sshpass build-essential fakeroot"

export AG_VERSION=2.1.0
export AG_URL=https://github.com/ggreer/the_silver_searcher/archive/${AG_VERSION}.tar.gz
export AG_SRCDIR=the_silver_searcher-${AG_VERSION}
export AG_CENTOS_DEPS="pcre-devel xz-devel zlib-devel"

export AXEL_VERSION=2.15
export AXEL_URL=https://github.com/eribertomota/axel/archive/v${AXEL_VERSION}.tar.gz
export AXEL_DEST_NAME=axel-${AXEL_VERSION}.tar.gz
export AXEL_SRCDIR=axel-${AXEL_VERSION}
export AXEL_CENTOS_DEPS="openssl-devel gettext-devel"

export GIT_VERSION=2.15.0
export GIT_URL=https://www.kernel.org/pub/software/scm/git/git-${GIT_VERSION}.tar.xz
export GIT_SRCDIR=git-${GIT_VERSION}
export GIT_CENTOS_DEPS="curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel asciidoc xmlto docbook2X"
export GIT_UBUNTU_DEPS="dh-autoreconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev docbook2x asciidoc"

export OVS_VERSION=2.8.1
export OVS_URL=http://openvswitch.org/releases/openvswitch-${OVS_VERSION}.tar.gz

export TIG_VERSION=2.2.2
export TIG_URL=https://github.com/jonas/tig/releases/download/tig-${VERSION}/tig-${VERSION}.tar.gz

export VIM_VERSION=8.0.1240
export VIM_URL=https://github.com/vim/vim/archive/v${VIM_VERSION}.tar.gz
export VIM_DEST_NAME=vim-${VIM_VERSION}.tar.gz
export VIM_SRCDIR=vim-${VIM_VERSION}
export VIM_CENTOS_DEPS="ncurses-devel ctags git libacl-devel cscope
  ruby ruby-devel lua lua-devel luajit luajit-devel  python python-devel python3 python3-devel tcl-devel \
  perl perl-devel perl-ExtUtils-ParseXS perl-ExtUtils-XSpp perl-ExtUtils-CBuilder perl-ExtUtils-Embed \
  gtk2-devel gtk3-devel"

clear_usrlocal() {
    rm -fr /usr/local/*
}

compress_binary() {
    local output=~/$1
    if [[ -n $OUTPUT ]]; then output=$OUTPUT/$1; fi
    echo "Generate $output"
    tar -C /usr/local -Jcf $output .
}

# We must support two CentOS version at the same time
# http://wiki.bash-hackers.org/syntax/pe
install_centos_deps() {
    releasever=$(python -c 'import yum; yb = yum.YumBase(); print yb.conf.yumvar["releasever"]' | tail -n 1)

    if [[ -n $CENTOS_DEPS ]]; then yum install -y -q $CENTOS_DEPS >/dev/null 2>&1; fi

    deps=$1_CENTOS${releasever}_DEPS
    if [[ -n ${!deps} ]]; then
        echo Install $deps \"${!deps}\"
        yum install -y -q ${!deps} >/dev/null 2>&1
    else
        deps=$1_CENTOS_DEPS
        if [[ -n ${!deps} ]]; then
            echo Install $deps \"${!deps}\"
            yum install -y -q ${!deps} >/dev/null 2>&1
        fi
    fi
}

install_fedora_deps() {
    if [[ -n $FEDORA_DEPS ]]; then dnf install -y -q $FEDORA_DEPS; fi
}

install_oraclelinux_deps() {
    if [[ -n $ORACLE_DEPS ]]; then yum install -y -q $ORACLE_DEPS; fi
}

install_ubuntu_deps() {
    if [[ -n $UBUNTU_DEPS ]]; then apt-get update -qq && apt-get install -y -qq -o "Dpkg::Use-Pty=0" $UBUNTU_DEPS >/dev/null; fi
}

install_deps() {
    [ -f /etc/centos-release ] && echo "build $1 for centos" && install_centos_deps $1
    [ -f /etc/fedora-relase ] && echo "build $1 for fedora" && install_fedora_deps $1
    [ -f /etc/oracle-release ] && echo "build $1 for oracle" && install_oraclelinux_deps $1
    [ -f /etc/lsb-release ] && grep -w -s -q Ubuntu /etc/lsb-release && echo "build $1 for ubuntu" && install_ubuntu_deps $1
}

prepare_build() {
    local url="$1_URL"
    local srcdir="$1_SRCDIR"
    local download="$1_DEST_NAME"
    if [[ -n ${!download} ]]; then download=${!download}; else download=$(basename ${!url}); fi

    (cd ~; [ -d ${!srcdir} ] && rm -fr ${!srcdir}; [ -f $download ] || { echo Download ${!url}; curl -L -o $download ${!url}; }; [ -f $download ] && tar -C ~ -xf $download)

    install_deps $1
}
