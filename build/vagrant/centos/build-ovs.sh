#!/bin/bash

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n ${OVS_VERSION} && -n ${OVS_URL} && -n ${OVS_SRCDIR} ]]; then
    prepare_build "OVS"

    if [ -d $HOME/${OVS_SRCDIR} ]; then
        [[ -f /etc/fedora-release ]] && dnf install -y -q "kernel-devel-uname-r == $(uname -r)"
        [[ -f /etc/fedora-release ]] || yum install -y -q "kernel-devel-uname-r == $(uname -r)"
        clear_usrlocal
        cd $HOME/${OVS_SRCDIR}
        ./configure
        make rpm-fedora RPMBUILD_OPT="--without dpdk --without check"
        make rpm-fedora-kmod RPMBUILD_OPT="-D \"kversion $(uname -r)\""
        if [[ -n $OUTPUT && -d $OUTPUT ]]; then
            find rpm/rpmbuild/RPMS -iname "*.rpm" -exec cp "{}" $OUTPUT/ \;
        else
            find rpm/rpmbuild/RPMS -iname "*.rpm" -exec cp "{}" $HOME/ \;
        fi
    else
        echo "Fail to download ovs"
    fi
else
    echo "Don't define variable ovs"
fi


