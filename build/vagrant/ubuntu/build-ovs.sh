#!/bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n ${OVS_VERSION} && -n ${OVS_URL} && -n ${OVS_SRCDIR} ]]; then
    prepare_build "OVS"

    if [ -d $HOME/${OVS_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${OVS_SRCDIR}
        dpkg-checkbuilddeps
        DEB_BUILD_OPTIONS="parallel=${NUM_CPUS} nocheck" fakeroot debian/rules binary
        (dpkg -i $HOME/openvswitch-datapath-source_2*_all.deb && \
            m-a --text-mode prepare && \
            m-a --text-mode build openvswitch-datapath) ||
            { echo >&2 "Unable to build kernel modules"; exit 1; }

        cp -pr /usr/src/openvswitch-datapath-module-*.deb $HOME/
        [[ -n $OUTPUT && -d $OUTPUT ]] && mv $HOME/*.deb $OUTPUT/
    else
        echo "Fail to download zsh"
    fi
else
    echo "Don't define variable zsh"
fi
