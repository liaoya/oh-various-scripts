#!/bin/sh

# https://devtidbits.com/2015/11/26/update-the-nano-text-editor-on-ubuntu/

[[ -f ../env.sh ]] && source ../env.sh

if [[ -n ${NANO_VERSION} && -n ${NANO_URL} && -n ${NANO_SRCDIR} ]]; then
    prepare_build "nano"

    if [ -d $HOME/${NANO_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${NANO_SRCDIR}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux --enable-utf8 --enable-libmagic
        make -s -j $(nproc) install-strip
        cat <<'EOF' >/usr/local/bin/install-nano.sh
#!/bin/sh
if [ $UID -eq 0 ]; then
    [[ -n $SYSCONFDIR ]] || SYSCONFDIR="/etc"
    CONF=$SYSCONFDIR/nanorc
else
    CONF=$HOME/.nanorc
fi

[ -f $CONF ] || touch $CONF
sed -i "/\/usr\/local\/share\/nano/d" $CONF || true
for item in $(ls -1 /usr/local/share/nano/*.nanorc); do echo "include $item" >> $CONF; done
EOF
        chmod a+x /usr/local/bin/install-nano.sh

        compress_binary nano-${NANO_VERSION} /usr/local/bin/nano
    else
        echo "Fail to download nano"
    fi
else
    echo "Don't define variable nano"
fi
