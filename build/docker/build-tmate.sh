#!/bin/bash

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n $TMATE_VERSION && -n $TMATE_URL && -n $TMATE_SRCDIR ]]; then
    prepare_build "tmate"

    if [ -d $HOME/$TMATE_SRCDIR ]; then
        clear_usrlocal

        cd $HOME/$TMATE_SRCDIR
        sh autogen.sh
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) install-strip
        cat <<'EOF' > /usr/local/bin/install-tmate.sh
#!/bin/sh
if [ $UID -eq 0 ]; then
    [ -f /etc/ld.so.conf.d/usr-local.conf ] || touch /etc/ld.so.conf.d/usr-local.conf
    grep -s -q -w "/usr/local/lib" /etc/ld.so.conf.d/usr-local.conf || echo "/usr/local/lib" >> /etc/ld.so.conf.d/usr-local.conf
    grep -s -q -w "/usr/local/lib64" /etc/ld.so.conf.d/usr-local.conf || echo "/usr/local/lib64" >> /etc/ld.so.conf.d/usr-local.conf
    ldconfig
    [[ -n $SYSCONFDIR ]] || SYSCONFDIR="/etc"
    CONF=$SYSCONFDIR/tmate.conf
else
    CONF=$HOME/.tmate.conf
fi

[ -f $CONF ] || touch $CONF
grep -s -q "set-option -g allow-rename off" $CONF || echo "set-option -g allow-rename off" >> $CONF
grep -s -q "set-option -g history-limit 10000" $CONF || echo "set-option -g history-limit 10000" >> $CONF
EOF
        chmod a+x /usr/local/bin/install-tmate.sh

        compress_binary tmate-${TMATE_VERSION} /usr/local/bin/tmate
    else
        echo "Fail to download tmate"
    fi
else
    echo "Don't define variable for tmate"
fi
