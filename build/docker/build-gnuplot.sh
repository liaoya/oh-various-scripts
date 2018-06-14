#!/bin/bash

[[ -f ../env.sh ]] && source ../env.sh

if [[ -n ${GNUPLOT_VERSION} && -n ${GNUPLOT_URL} && -n ${GNUPLOT_SRCDIR} ]]; then
    prepare_build "gnuplot"

    if [ -d $HOME/${GNUPLOT_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${GNUPLOT_SRCDIR}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) install-strip

        compress_binary gnuplot-${GNUPLOT_VERSION} /usr/local/bin/gnuplot
    else
        echo "Fail to download gnuplot"
    fi
else
    echo "Don't define variable for gnuplot"
fi
