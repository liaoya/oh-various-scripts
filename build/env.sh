#!/bin/bash

export SILENCE=1

export CENTOS_DEPS="autoconf automake libtool gcc gcc-c++ make file which pxz pigz lbzip2 unzip bzip2 xz lzip openssh-clients"
export UBUNTU_DEPS="curl less openssh-client sshpass build-essential fakeroot pkg-config"

export AG_VERSION=2.1.0
export AG_URL=https://github.com/ggreer/the_silver_searcher/archive/${AG_VERSION}.tar.gz
export AG_SRCDIR=the_silver_searcher-${AG_VERSION}
export AG_CENTOS_DEPS="pcre-devel xz-devel zlib-devel"
export AG_UBUNTU_DEPS="libpcre3-dev liblzma-dev zlib1g-dev"

export AXEL_VERSION=2.15
export AXEL_URL=https://github.com/eribertomota/axel/archive/v${AXEL_VERSION}.tar.gz
export AXEL_SRCDIR=axel-${AXEL_VERSION}
export AXEL_ARCHIVE_NAME=axel-${AXEL_VERSION}.tar.gz
export AXEL_CENTOS_DEPS="openssl-devel gettext-devel"
export AXEL_UBUNTU_DEPS="libssl-dev gettext"

export CURL_VERSION=7.56.1
export CURL_URL=https://curl.haxx.se/download/curl-${CURL_VERSION}.tar.bz2
export CURL_SRCDIR=curl-${CURL_VERSION}
export CURL_CENTOS_DEPS="openssl-devel gnutls-devel nss-devel libssh2-devel zlib-devel c-ares-devel libidn2-devel libnghttp2-devel libpsl-devel libmetalink-devel openldap-devel"
export CURL_UBUNTU_DEPS="libssl-dev libgnutls28-dev libssh2-1-dev libz-dev libc-ares-dev libidn2-dev libnghttp2-dev libpsl-dev libldap2-dev"

export GIT_VERSION=2.15.0
export GIT_URL=https://www.kernel.org/pub/software/scm/git/git-${GIT_VERSION}.tar.xz
export GIT_SRCDIR=git-${GIT_VERSION}
export GIT_CENTOS_DEPS="curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel asciidoc xmlto docbook2X"
export GIT_UBUNTU_DEPS="dh-autoreconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev docbook2x asciidoc"

export OVS_VERSION=2.8.1
export OVS_URL=http://openvswitch.org/releases/openvswitch-${OVS_VERSION}.tar.gz

export TIG_VERSION=2.3.0
export TIG_URL=https://github.com/jonas/tig/archive/tig-${TIG_VERSION}.tar.gz
export TIG_SRCDIR=tig-tig-${TIG_VERSION}
export TIG_CENTOS_DEPS="ncurses-devel"
export TIG_UBUNTU_DEPS="libncurses-dev"

export TMUX_VERSION=2.6
export TMUX_URL=https://github.com/tmux/tmux/releases/download/2.6/tmux-${TMUX_VERSION}.tar.gz
export TMUX_SRCDIR=tmux-${TMUX_VERSION}
export TMUX_CENTOS_DEPS="ncurses-devel libevent-devel"
export TMUX_UBUNTU_DEPS="libncurses-dev libevent-dev"

export VIM_VERSION=8.0.1240
export VIM_URL=https://github.com/vim/vim/archive/v${VIM_VERSION}.tar.gz
export VIM_SRCDIR=vim-${VIM_VERSION}
export VIM_ARCHIVE_NAME=vim-${VIM_VERSION}.tar.gz
export VIM_CENTOS_DEPS="ncurses-devel ctags git libacl-devel cscope \
  ruby ruby-devel lua lua-devel luajit luajit-devel python python-devel python3 python3-devel tcl-devel perl perl-devel \
  perl-ExtUtils-ParseXS perl-ExtUtils-XSpp perl-ExtUtils-CBuilder perl-ExtUtils-Embed \
  gtk2-devel gtk3-devel"
export VIM_UBUNTU_DEPS="libncurses-dev git libacl1-dev cscope \
  ruby ruby-dev lua lua-dev python python-dev python3 python3-dev tcl-dev perl perl-dev \
  libgtk2.0-dev"

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
    releasever=$(python -c 'import dnf; print(dnf.Base().conf.releasever)' | tail -n 1)

    if [[ -n $FEDORA_DEPS ]]; then dnf install -y -q $FEDORA_DEPS; fi

}

install_oraclelinux_deps() {
    if [[ -n $ORACLE_DEPS ]]; then yum install -y -q $ORACLE_DEPS; fi
}

install_ubuntu_deps() {
    if [[ -n $UBUNTU_DEPS ]]; then apt-get update -qq && apt-get install -y -qq -o "Dpkg::Use-Pty=0" $UBUNTU_DEPS >/dev/null 2>&1; fi

    deps=$1_UBUNTU_$(lsb_release -sc | awk '{print toupper($0)}')_DEPS
    if [[ -n ${!deps} ]]; then
        echo Install $deps \"${!deps}\"
        [ $SILENCE -eq 0 ] && apt-get install -y -qq ${!deps}
        [ $SILENCE -ne 0 ] && apt-get install -y -qq -o "Dpkg::Use-Pty=0" ${!deps} >/dev/null 2>&1
    else
        deps=$1_UBUNTU_DEPS
        if [[ -n ${!deps} ]]; then
            echo Install $deps \"${!deps}\"
            [ $SILENCE -eq 0 ] && apt-get install -y -qq ${!deps}
            [ $SILENCE -ne 0 ] && apt-get install -y -qq -o "Dpkg::Use-Pty=0" ${!deps} >/dev/null 2>&1
        fi
    fi
}

install_deps() {
    [ -f /etc/centos-release ] && echo "build $1 for centos" && install_centos_deps $1
    [ -f /etc/fedora-relase ] && echo "build $1 for fedora" && install_fedora_deps $1
    [ -f /etc/oracle-release ] && echo "build $1 for oracle" && install_oraclelinux_deps $1
    [ -f /etc/lsb-release ] && grep -w -s -q Ubuntu /etc/lsb-release && echo "build $1 for ubuntu" && install_ubuntu_deps $1
}

prepare_build() {
    install_deps $1

    local url="$1_URL"
    local srcdir="$1_SRCDIR"
    local download="$1_ARCHIVE_NAME"
    if [[ -n ${!download} ]]; then download=${!download}; else download=$(basename ${!url}); fi

    (cd ~; [ -d ${!srcdir} ] && rm -fr ${!srcdir}; [ -f $download ] || { echo Download ${!url}; curl -L -o $download ${!url}; }; [ -f $download ] && tar -C ~ -xf $download)
}
