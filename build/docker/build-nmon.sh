#!/bin/bash
#shellcheck disable=SC1090,SC2164

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source "${THIS_DIR}/../env.sh"

if [[ -n ${NMON_VERSION} && -n ${NMON_SOURCE} && -n ${NMON_MAKEFILE} ]]; then
    install_deps "nmon"

    cd ${HOME}
    download_source ${NMON_SOURCE} lmon.c
    download_source ${NMON_MAKEFILE} Makefile

    if [ -f /etc/redhat-release ]; then
        if [[ -f /etc/fedora-release ]]; then
            make nmon_x86_fedora25; mkdir -p /usr/local/bin; cp -pr nmon_x86_fedora25 /usr/local/bin/nmon
        else
            releasever=$(python -c 'import yum; yb = yum.YumBase(); print yb.conf.yumvar["releasever"]' | tail -n 1)
            [[ $releasever == "7" ]] && { make nmon_x86_rhel70; mkdir -p /usr/local/bin; cp -pr nmon_x86_rhel70 /usr/local/bin/nmon; }
            [[ $releasever == "6" ]] && { make nmon_x86_rhel6; mkdir -p /usr/local/bin; cp -pr nmon_x86_rhel6 /usr/local/bin/nmon; }
        fi
    fi

    [ -f /etc/lsb-release ] && grep -w -s -q Ubuntu /etc/lsb-release && { make nmon_x86_ubuntu1604; mkdir -p /usr/local/bin; cp -pr nmon_x86_ubuntu1604 /usr/local/bin/nmon; }

    compress_binary nmon-${NMON_VERSION} /usr/local/bin/nmon
else
    echo "Don't define variable nmon"
fi
