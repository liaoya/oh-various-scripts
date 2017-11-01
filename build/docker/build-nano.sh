#!/bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n ${NANO_VERSION} && -n ${NANO_URL} && -n ${NANO_SRCDIR} ]]; then
    prepare_build "NANO"

    if [ -d ~/${NANO_SRCDIR} ]; then
        clear_usrlocal
        cd ~/${NANO_SRCDIR}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) install-strip
        cat <<EOF >>/usr/local/bin/install-nano
#!/bin/sh
[ -f ~/.nanorc ] && sed -i "/\/usr\/local\/share\/nano/d" ~/.nanorc
for item in \$(ls -1 /usr/local/share/nano/*.nanorc); do echo "include \$item" >> ~/.nanorc; done
EOF
        chmod a+x /usr/local/bin/install-nano

        compress_binary nano-${NANO_VERSION}.txz
    else
        echo "Fail to download nano"
    fi
else
    echo "Don't define variable nano"
fi
