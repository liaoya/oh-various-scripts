#!/bin/bash
#shellcheck disable=SC1090,SC2164

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source "${THIS_DIR}/../env.sh"

if [[ -n ${PYTHON3_VERSION} && -n ${PYTHON3_URL} && -n ${PYTHON3_SRCDIR} ]]; then
    prepare_build "python3"

    if [ -d $HOME/${PYTHON3_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${PYTHON3_SRCDIR}
        ./configure -q --enable-optimizations --enable-shared --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc)
        make -s altinstall
        for item in $(ls -1 /usr/local/bin/python3*); do file $item | grep -q -s "not stripped" && strip $item; done 
        for item in $(ls -1 /usr/local/lib/libpython3*); do file $item | grep -q -s "not stripped" && strip $item; done 
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
        /usr/local/bin/pip3.6 install -U virtualenv
        mv /usr/local/bin/virtualenv /usr/local/bin/virtualenv-3.6

        compress_binary python-${PYTHON3_VERSION} /usr/local/bin/python3.6
    else
        echo "Fail to download python"
    fi
else
    echo "Don't define variable python"
fi
