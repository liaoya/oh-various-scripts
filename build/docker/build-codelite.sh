#!/bin/sh

[[ -f ../env.sh ]] && source ../env.sh

if [[ -n ${CODELITE_VERSION} && -n ${CODELITE_URL} && -n ${CODELITE_SRCDIR} ]]; then
    prepare_build "codelite"

    if [ -d $HOME/${CODELITE_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${CODELITE_SRCDIR}
        [ -f /usr/bin/wx-config ] && mv /usr/bin/wx-config /usr/bin/wx-config.origin
        ln -s /usr/bin/wx-config-3.0 /usr/bin/wx-config
        cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCL_PREFIX=/usr/local
        make -s -j $(nproc) all
        make -s install/strip

        [ -f /usr/bin/wx-config.origin ] && mv -f /usr/bin/wx-config.origin /usr/bin/wx-config

        compress_binary codelite-${CODELITE_VERSION} /usr/local/bin/codelite
    else
        echo "Fail to download codelite"
    fi
else
    echo "Don't define variable codelite"
fi

