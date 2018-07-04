#!/bin/bash

export SILENCE=1

export CENTOS_DEPS="file wget autoconf automake libtool gcc gcc-c++ make file which pxz pigz lbzip2 unzip bzip2 xz p7zip openssh-clients yum-utils"
export FEDORA_DEPS="file wget autoconf automake libtool gcc gcc-c++ make file which pxz pigz lbzip2 unzip bzip2 xz p7zip openssh-clients python2-dnf yum-utils"
export UBUNTU_DEPS="lsb-release curl wget less file pxz pigz lbzip2 unzip bzip2 xz-utils p7zip-full openssh-client sshpass build-essential fakeroot pkg-config autoconf libtool groff texinfo"

export AG_VERSION=2.1.0
export AG_URL=https://github.com/ggreer/the_silver_searcher/archive/${AG_VERSION}.tar.gz
export AG_ARCHIVE_NAME=ag-${AG_VERSION}.tar.gz
export AG_SRCDIR=the_silver_searcher-${AG_VERSION}
export AG_CENTOS_DEPS="pcre-devel xz-devel zlib-devel"
export AG_UBUNTU_DEPS="libpcre3-dev liblzma-dev zlib1g-dev"

export AXEL_VERSION=2.15
export AXEL_URL=https://github.com/eribertomota/axel/archive/v${AXEL_VERSION}.tar.gz
export AXEL_ARCHIVE_NAME=axel-${AXEL_VERSION}.tar.gz
export AXEL_SRCDIR=axel-${AXEL_VERSION}
export AXEL_CENTOS_DEPS="openssl-devel gettext-devel"
export AXEL_UBUNTU_DEPS="libssl-dev gettext"

export BASH_VERSION=4.4.18
export BASH_URL=http://ftpmirror.gnu.org/gnu/bash/bash-${BASH_VERSION}.tar.gz
export BASH_SRCDIR=bash-${BASH_VERSION}
export BASH_CENTOS_DEPS="ncurses-devel"
export BASH_UBUNTU_DEPS="libncurses-dev"

export BOOST_VERSION=1.67
export BOOST_URL=https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/boost_$(echo $BOOST_VERSION | sed -e 's%\.%_%g').7z
export BOOST_SRCDIR=boost_$(echo $BOOST_VERSION | sed -e 's%\.%_%g')
export BOOST_CENTOS_DEPS="zlib-devel bzip2-devel libicu-devel python-devel openmpi-devel xz-devel"
export BOOST_UBUNTU_DEPS="libz-dev libbz2-dev libicu-dev python3-dev python-dev"

export CODELITE_VERSION=12.0
export CODELITE_URL=https://github.com/eranif/codelite/archive/${CODELITE_VERSION}.tar.gz
export CODELITE_ARCHIVE_NAME=codelite-${CODELITE_VERSION}.tar.gz
export CODELITE_SRCDIR=codelite-${CODELITE_VERSION}
export CODELITE_CENTOS_DEPS="wxGTK3-devel cmake sqlite-devel libssh-devel clang-devel hunspell-devel lldb-devel flex-devel"
export CODELITE_UBUNTU_DEPS=""

export CURL_VERSION=7.60.0
export CURL_URL=https://curl.haxx.se/download/curl-${CURL_VERSION}.tar.bz2
export CURL_SRCDIR=curl-${CURL_VERSION}
export CURL_CENTOS_DEPS="openssl-devel gnutls-devel nss-devel libssh2-devel zlib-devel c-ares-devel libidn2-devel libnghttp2-devel libpsl-devel libmetalink-devel openldap-devel"
export CURL_UBUNTU_DEPS="libssl-dev libgnutls28-dev libssh2-1-dev libz-dev libc-ares-dev libidn2-dev libnghttp2-dev libpsl-dev libldap2-dev"

export EMACS_VERSION=26.1
export EMACS_URL=http://ftpmirror.gnu.org/gnu/emacs/emacs-${EMACS_VERSION}.tar.xz
export EMACS_SRCDIR=emacs-${EMACS_VERSION}
export EMACS_CENTOS_DEPS="GConf2-devel dbus-devel giflib-devel gnutls-devel gtk3-devel gpm-devel \
    libX11-devel libXpm-devel libacl-devel libjpeg-turbo-devel libotf-devel librsvg2-devel libtiff-devel \
    libselinux-devel libxml2-devel m17n-lib-devel ncurses-devel \
    openjpeg-devel openjpeg2-devel turbojpeg-devel wxGTK-devel wxGTK3-devel"
export EMACS_UBUNTU_DEPS="libncurses-dev libevent-dev libgnutls28-dev"

export FISH_VERSION=2.7.1
export FISH_URL=https://github.com/fish-shell/fish-shell/releases/download/${FISH_VERSION}/fish-${FISH_VERSION}.tar.gz
export FISH_SRCDIR=fish-${FISH_VERSION}
export FISH_CENTOS_DEPS="ncurses-devel pcre2-devel"
export FISH_UBUNTU_DEPS="libncurses-dev libpcre2-dev"

export GCC_VERSION=8.1.0
export GCC_URL=http://ftpmirror.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.xz
export GCC_SRCDIR=gcc-${GCC_VERSION}
export GCC_CENTOS_DEPS="gmp-devel libmpc-devel"
export GCC_UBUNTU_DEPS=""

export GDB_VERSION=8.1
export GDB_URL=http://ftpmirror.gnu.org/gdb/gdb-${GDB_VERSION}.tar.xz
export GDB_SRCDIR=gdb-${GDB_VERSION}
export GDB_CENTOS_DEPS="bison flex expect texinfo"
export GDB_UBUNTU_DEPS=""

export GIT_VERSION=2.18.0
export GIT_URL=https://www.kernel.org/pub/software/scm/git/git-${GIT_VERSION}.tar.xz
export GIT_SRCDIR=git-${GIT_VERSION}
export GIT_CENTOS_DEPS="curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel asciidoc xmlto docbook2X git"
export GIT_UBUNTU_DEPS="dh-autoreconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev docbook2x asciidoc"

export GFLAGS_CENTOS_DEPS="cmake3"
export GFLAGS_UBUNTU_DEPS=""

export GLOBAL_VERSION=6.6.2
export GLOBAL_URL=http://ftpmirror.gnu.org/gnu/global/global-${GLOBAL_VERSION}.tar.gz
export GLOBAL_SRCDIR=global-${GLOBAL_VERSION}
export GLOBAL_CENTOS_DEPS="ncurses-devel"
export GLOBAL_UBUNTU_DEPS="libncurses-dev"

export GNUPLOT_VERSION=5.2.4
export GNUPLOT_URL=https://sourceforge.net/projects/gnuplot/files/gnuplot/${GNUPLOT_VERSION}/gnuplot-${GNUPLOT_VERSION}.tar.gz
export GNUPLOT_SRCDIR=gnuplot-${GNUPLOT_VERSION}
export GNUPLOT_CENTOS_DEPS="atk-devel cairo-devel expat-devel gtk2-devel \
    libacl-devel libjpeg-turbo-devel libpng-devel libtiff-devel \
    pcre-devel pango-devel wxGTK-devel zlib-devel"
export GNUPLOT_UBUNTU_DEPS="libatk1.0-dev libcairo2-dev libexpat1-dev libgtk2.0-dev \
    libacl1-dev libjpeg-dev libjpeg-turbo8-dev libpng-dev libtiff5-dev \
    libcerf-dev libpcre2-dev libpcre3-dev zlib1g-dev libcerf-dev libgd-dev"

export GOOGLETEST_VERSION=2.2.1
export GOOGLETEST_URL=https://github.com/google/googletest/archive/${GOOGLETEST_VERSION}.tar.gz
export GOOGLETEST_ARCHIVE_NAME=googletest-${GOOGLETEST_VERSION}.tar.gz
export GOOGLETEST_SRCDIR=googletest-v${GOOGLETEST_VERSION}
export GOOGLETEST_CENTOS_DEPS="cmake3"
export GOOGLETEST_UBUNTU_DEPS=""

# grpc can't be build
GRPC_VERSION=$(curl -s "https://api.github.com/repos/grpc/grpc/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
export GRPC_VERSION=${GRPC_VERSION:1}
export GRPC_URL=https://github.com/grpc/grpc/archive/v${GRPC_VERSION}.tar.gz
export GRPC_ARCHIVE_NAME=grpc-${GRPC_VERSION}.tar.gz
export GRPC_SRCDIR=grpc-${GRPC_VERSION}
export GRPC_PROTOBUF_VERSION=3.4.0
export GRPC_PROTOBUF_URL=https://github.com/google/protobuf/archive/v${GRPC_PROTOBUF_VERSION}.tar.gz
export GRPC_PROTOBUF_ARCHIVE_NAME=protobuf-${GRPC_PROTOBUF_VERSION}.tar.gz
export GRPC_PROTOBUF_SRCDIR=protobuf-${GRPC_PROTOBUF_VERSION}
export GRPC_CARES_VERSION=1.12.0
export GRPC_CARES_URL=https://c-ares.haxx.se/download/c-ares-${GRPC_CARES_VERSION}.tar.gz
export GRPC_CARES_SRCDIR=c-ares-${GRPC_CARES_VERSION}
export GRPC_JAVA_VERSION=1.7.0
export GRPC_JAVA_URL=https://github.com/grpc/grpc-java/archive/v${GRPC_JAVA_VERSION}.tar.gz
export GRPC_JAVA_ARCHIVE_NAME=grpc-java-${GRPC_JAVA_VERSION}.tar.gz
export GRPC_JAVA_SRCDIR=grpc-java-${GRPC_JAVA_VERSION}
export GRPC_CENTOS_DEPS="zlib-devel openssl-devel gnutls-devel"
export GRPC_UBUNTU_DEPS="libncurses-dev libevent-dev"

export HIGHLIGHT_VERSION=3.42
export HIGHLIGHT_URL=http://www.andre-simon.de/zip/highlight-${HIGHLIGHT_VERSION}.tar.bz2
export HIGHLIGHT_SRCDIR=highlight-${HIGHLIGHT_VERSION}
export HIGHLIGHT_CENTOS_DEPS="lua-devel boost-devel"
export HIGHLIGHT_UBUNTU_DEPS=""

export IPERF3_VERSION=3.2
export IPERF3_URL=https://github.com/esnet/iperf/archive/${IPERF3_VERSION}.tar.gz
export IPERF3_ARCHIVE_NAME=iperf-${IPERF3_VERSION}.tar.gz
export IPERF3_SRCDIR=iperf-${IPERF3_VERSION}
export IPERF3_CENTOS_DEPS="openssl-devel file"
export IPERF3_UBUNTU_DEPS="libssl-dev file"

export LFTP_VERSION=4.8.3
export LFTP_URL=http://lftp.yar.ru/ftp/lftp-${LFTP_VERSION}.tar.xz
export LFTP_SRCDIR=lftp-${LFTP_VERSION}
export LFTP_CENTOS_DEPS="ncurses-devel readline-devel gnutls-devel zlib-devel libidn2-devel"
export LFTP_UBUNTU_DEPS="libncurses-dev libreadline-dev libgnutls28-dev zlib1g-dev libidn2-dev"

export LLVM_VERSION=6.0.0
export LLVM_CENTOS_DEPS="cmake3"
export LLVM_FEDORA_DEPS="cmake"
export LLVM_UBUNTU_DEPS="cmake"

export MC_VERSION=4.8.21
export MC_URL=http://ftp.midnight-commander.org/mc-${MC_VERSION}.tar.xz
export MC_SRCDIR=mc-${MC_VERSION}
export MC_CENTOS_DEPS="ncurses-devel glib2-devel slang-devel gpm-devel libssh2-devel openssl-libs-devel zlib-devel krb5-libs-devel libcom_err-devel keyutils-libs-devel pcre-devel libselinux-devel doxygen"
export MC_FEDORA_DEPS="glib2-devel slang-devel"
export MC_UBUNTU_DEPS="libncurses-dev libglib2.0-dev"

export NANO_MAJOR_VERSION=2.9
export NANO_MINOR_VERSION=8
export NANO_VERSION=${NANO_MAJOR_VERSION}.${NANO_MINOR_VERSION}
export NANO_URL=https://www.nano-editor.org/dist/v${NANO_MAJOR_VERSION}/nano-${NANO_VERSION}.tar.xz
export NANO_SRCDIR=nano-${NANO_VERSION}
export NANO_CENTOS_DEPS="ncurses-devel zlib-devel"
export NANO_UBUNTU_DEPS="libncurses-dev zlib1g-dev libmagic-dev groff texinfo"

export NINJA_CENTOS_DEPS="re2c"
export NINJA_UBUNTU_DEPS="python"

export NMON_VERSION=16g
export NMON_SOURCE=https://sourceforge.net/projects/nmon/files/lmon${NMON_VERSION}.c
export NMON_MAKEFILE=https://sourceforge.net/projects/nmon/files/makefile
export NMON_CENTOS_DEPS="ncurses-devel"
export NMON_UBUNTU_DEPS="libncurses-dev"

export OVS_VERSION=2.9.2
export OVS_URL=http://openvswitch.org/releases/openvswitch-${OVS_VERSION}.tar.gz
export OVS_SRCDIR=openvswitch-${OVS_VERSION}
export OVS_CENTOS_DEPS="rpm-build systemd-units openssl openssl-devel \
    python2-devel python-six groff python-sphinx python-twisted-core python-zope-interface \
    desktop-file-utils groff graphviz procps-ng checkpolicy selinux-policy-devel \
    libcap-ng libcap-ng-devel"
export OVS_UBUNTU_DEPS="module-assistant debhelper dh-autoreconf libssl-dev libtool openssl procps \
    python-all python-qt4 python-twisted-conch python-zopeinterface python-six libcap-ng-dev"

export PROTOBUF_ARCHIVE_NAME=protobuf-${PROTOBUF_VERSION}.tar.gz
export PROTOBUF_SRCDIR=protobuf-${PROTOBUF_VERSION}

export PYTHON3_VERSION=3.6.5
export PYTHON3_URL=https://www.python.org/ftp/python/${PYTHON3_VERSION}/Python-${PYTHON3_VERSION}.tgz
export PYTHON3_SRCDIR=Python-${PYTHON3_VERSION}
export PYTHON3_CENTOS_DEPS="zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel expat-devel"
export PYTHON3_UBUNTU_DEPS=""

export RIPGREP_CENTOS_DEPS="rust cargo"
export RIPGREP_UBUNTU_DEPS="rustc cargo"

export SSHPASS_VERSION=1.06
export SSHPASS_URL=https://sourceforge.net/projects/sshpass/files/sshpass/${SSHPASS_VERSION}/sshpass-${SSHPASS_VERSION}.tar.gz
export SSHPASS_SRCDIR=sshpass-${SSHPASS_VERSION}

export SOURCE_HIGHLIGHT_VERSION=3.1.8
export SOURCE_HIGHLIGHT_URL=http://ftpmirror.gnu.org/gnu/src-highlite/source-highlight-${SOURCE_HIGHLIGHT_VERSION}.tar.gz
export SOURCE_HIGHLIGHT_SRCDIR=source-highlight-${SOURCE_HIGHLIGHT_VERSION}
export SOURCE_HIGHLIGHT_CENTOS_DEPS="ctags doxygen help2man boost-devel"
export SOURCE_HIGHLIGHT_UBUNTU_DEPS="exuberant-ctags doxygen help2man libboost-regex-dev"

export SWIG_VERSION=3.0.12
export SWIG_URL=https://sourceforge.net/projects/swig/files/swig/swig-${SWIG_VERSION}/swig-${SWIG_VERSION}.tar.gz
export SWIG_SRCDIR=swig-${SWIG_VERSION}
export SWIG_CENTOS_DEPS="pcre2-devel pcre-devel bison byacc zlib-devel"
export SWIG_UBUNTU_DEPS="libpcre2-dev libpcre3-dev bison byacc zlib1g-dev"

export TIG_CENTOS_DEPS="ncurses-devel"
export TIG_UBUNTU_DEPS="libncurses-dev"

export TMATE_CENTOS_DEPS="ncurses-devel libevent-devel msgpack-devel libssh-devel libssh2-devel"
export TMATE_UBUNTU_DEPS="libncurses-dev libevent-dev"

export TMUX_CENTOS_DEPS="ncurses-devel libevent-devel"
export TMUX_CENTOS6_DEPS="ncurses-devel libevent2-devel"
export TMUX_UBUNTU_DEPS="libncurses-dev libevent-dev"

export VIM_VERSION=8.1.0055
export VIM_URL=https://github.com/vim/vim/archive/v${VIM_VERSION}.tar.gz
export VIM_ARCHIVE_NAME=vim-${VIM_VERSION}.tar.gz
export VIM_SRCDIR=vim-${VIM_VERSION}
export VIM_CENTOS_DEPS="ncurses-devel ctags git libacl-devel cscope \
    ruby ruby-devel lua lua-devel luajit luajit-devel python python-devel python3 python3-devel tcl-devel perl perl-devel \
    perl-ExtUtils-ParseXS perl-ExtUtils-XSpp perl-ExtUtils-CBuilder perl-ExtUtils-Embed \
    gtk2-devel gtk3-devel"
export VIM_UBUNTU_DEPS="libncurses-dev exuberant-ctags git libacl1-dev cscope \
    ruby ruby-dev lua lua-dev python python-dev python3 python3-dev tcl-dev perl perl-dev \
    libgtk2.0-dev"

# Fail to build on Ubuntu 17.04 with gcc 7.2
export UCG_CENTOS_DEPS="pcre2-devel pcre-devel jemalloc-devel"
export UCG_UBUNTU_DEPS="libpcre2-dev libpcre3-dev libjemalloc-dev"

export ZSH_VERSION=5.5.1
export ZSH_URL=https://sourceforge.net/projects/zsh/files/zsh/${ZSH_VERSION}/zsh-${ZSH_VERSION}.tar.xz
export ZSH_SRCDIR=zsh-${ZSH_VERSION}
export ZSH_CENTOS_DEPS="ncurses-devel bison"
export ZSH_UBUNTU_DEPS="libncurses-dev bison"

clear_usrlocal() {
    rm -fr /usr/local/*
}

compress_binary() {
    [[ $# -lt 2 ]] && { echo "compress_binary <compress file name> <check file>"; exit 1; }
    local output=$HOME/$1
    [[ -n $OUTPUT ]] && output=$OUTPUT/$1
    if [[ -f $2 ]]; then
        if [[ $(command -v pxz) ]]; then
            echo "Generate ${output}.txz"; tar -I pxz -C /usr/local -cf ${output}.txz .
        elif [[ $(command -v pxz) ]]; then
            echo "Generate ${output}.txz"; tar -C /usr/local -Jcf ${output}.txz .
        elif [[ $(command -v lbzip2) ]]; then
            echo "Generate ${output}.tbz"; tar -I lbzip2 -C /usr/local -cf ${output}.tbz .
        elif [[ $(command -v bzip2) ]]; then
            echo "Generate ${output}.tbz"; tar -C /usr/local -jcf ${output}.tbz .
        elif [[ $(command -v pigz) ]]; then
            echo "Generate ${output}.tgz"; tar -I pigz -C /usr/local -cf ${output}.tgz .
        else
            echo "Generate ${output}.tgz"; tar -C /usr/local -zcf ${output}.tgz .
        fi
    fi
}

download_source() {
    local output=$HOME/$(basename $1)
    [[ $# -eq 2 ]] && output=$2
    [[ ! -f $output ]] && echo "Download $1 as $output " && curl -s -L -o $output $1
}

# We must support two CentOS version at the same time
# http://wiki.bash-hackers.org/syntax/pe
install_centos_deps() {
    releasever=$(python -c 'import yum; yb = yum.YumBase(); print yb.conf.yumvar["releasever"]' | tail -n 1)

    if [[ -n $CENTOS_DEPS ]]; then echo "Install CENTOS_DEPS \"$CENTOS_DEPS\""; yum install -y -q $CENTOS_DEPS >/dev/null 2>&1; fi

    # yum-builddep -y $1
    deps=${1^^}_CENTOS${releasever}_DEPS
    if [[ -n ${!deps} ]]; then
        echo Install $deps \"${!deps}\"
        yum install -y -q ${!deps} >/dev/null 2>&1
    else
        deps=${1^^}_CENTOS_DEPS
        if [[ -n ${!deps} ]]; then
            echo Install $deps \"${!deps}\"
            yum install -y -q ${!deps} >/dev/null 2>&1
        fi
    fi
}

install_fedora_deps() {
    # releasever=$(python -c 'import dnf; print(dnf.Base().conf.releasever)' | tail -n 1)

    if [[ -n $FEDORA_DEPS ]]; then echo "Install FEDORA_DEPS \"$FEDORA_DEPS\""; dnf install -y -q $FEDORA_DEPS >/dev/null 2>&1; fi
    deps=${1^^}_FEDORA_DEPS
    if [[ -n ${!deps} ]]; then
        echo Install $deps \"${!deps}\"
        dnf install -y -q ${!deps} >/dev/null 2>&1
    else
        deps=${1^^}_CENTOS_DEPS
        if [[ -n ${!deps} ]]; then
            echo Install $deps \"${!deps}\"
            dnf install -y -q ${!deps} >/dev/null 2>&1
        fi
    fi
}

install_oraclelinux_deps() {
    releasever=$(python -c 'import yum; yb = yum.YumBase(); print yb.conf.yumvar["releasever"]' | tail -n 1)
    releasever=${releasever:0:1}
    if [[ -n $ORACLE_DEPS ]]; then yum install -y -q $ORACLE_DEPS; fi
        if [[ -n $CENTOS_DEPS ]]; then echo "Install CENTOS_DEPS \"$CENTOS_DEPS\""; yum install -y -q $CENTOS_DEPS >/dev/null 2>&1; fi

    # yum-builddep -y $1
    deps=${1^^}_CENTOS${releasever}_DEPS
    if [[ -n ${!deps} ]]; then
        echo Install $deps \"${!deps}\"
        yum install -y -q ${!deps} >/dev/null 2>&1
    else
        deps=${1^^}_CENTOS_DEPS
        if [[ -n ${!deps} ]]; then
            echo Install $deps \"${!deps}\"
            yum install -y -q ${!deps} >/dev/null 2>&1
        fi
    fi
}

install_ubuntu_deps() {
    if [[ -n $UBUNTU_DEPS ]]; then echo "Install UBUNTU_DEPS \"$UBUNTU_DEPS\""; apt-get update -qq && apt-get install -y -qq -o "Dpkg::Use-Pty=0" $UBUNTU_DEPS >/dev/null 2>&1; fi

    apt-get -y build-dep $1
    deps=${1^^}_UBUNTU_$(lsb_release -sc | awk '{print toupper($0)}')_DEPS
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
    if [ -f /etc/redhat-release ]; then
        distro=$(rpm -qf --queryformat '%{NAME}' /etc/redhat-release | cut -f 1 -d '-')
        [ $distro == "centos" ] && echo "build $1 for $distro" && install_centos_deps $1
        [ $distro == "fedora" ] && echo "build $1 for $distro" && install_fedora_deps $1
        [ $distro == "oraclelinux" ] && echo "build $1 for $distro" && install_oraclelinux_deps $1
    fi
    [ -f /etc/lsb-release ] && grep -w -s -q Ubuntu /etc/lsb-release && echo "build $1 for ubuntu" && install_ubuntu_deps $1
}

prepare_build() {
    install_deps $1

    local url="${1^^}_URL"
    local srcdir="${1^^}_SRCDIR"
    local download="${1^^}_ARCHIVE_NAME"
    if [[ -n ${!download} ]]; then download=${!download}; else download=$(basename ${!url}); fi

    download_source ${!url} $HOME/${download}
    [[ -n ${!srcdir} && -d $HOME/${!srcdir} ]] && { echo "Remove $HOME/${!srcdir}"; rm -fr $HOME/${!srcdir}; }

    if [ -f $HOME/${download} ]; then
        file $HOME/${download} | grep -s -w -q "7-zip archive data" && (cd $HOME; 7za x -aoa -bd -y ${download})
        file $HOME/${download} |  grep -q -w -s -e "XZ compressed data" -e "gzip compressed data" -e "bzip2 compressed data" && tar -C $HOME -xf $HOME/${download}
    fi
    # (cd $HOME; [ -d ${!srcdir} ] && rm -fr ${!srcdir}; [ -f $download ] || { echo Download ${!url}; curl -L -o $download ${!url}; }; [ -f $download ] && tar -C $HOME -xf $download)
}
