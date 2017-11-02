#!/bin/bash

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n $TMUX_VERSION && -n $TMUX_URL && -n $TMUX_SRCDIR ]]; then
    prepare_build "TMUX"

    if [ -d $HOME/$TMUX_SRCDIR ]; then
        clear_usrlocal

        if [ -f /etc/redhat-release ]; then
            releasever=$(python -c 'import yum; yb = yum.YumBase(); print yb.conf.yumvar["releasever"]' | tail -n 1)
            if [ $releasever == "6" ]; then
                LIBEVENT_VERSION=2.0.22
                curl -L https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}-stable/libevent-${LIBEVENT_VERSION}-stable.tar.gz | tar -xz -C ~
                cd $HOME/libevent-${LIBEVENT_VERSION}-stable
                ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
                make -s -j $(nproc) all
                make install-strip
            fi
        fi

        cd $HOME/tmux-${TMUX_VERSION}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) install-strip
        cat <<EOF > /usr/local/bin/install-tmux
#!/bin/sh
if [ $UID -eq 0 ]; then
    [ -f /etc/ld.so.conf.d/usr-local.conf ] || touch /etc/ld.so.conf.d/usr-local.conf
    grep -s -q -w "/usr/local/lib" /etc/ld.so.conf.d/usr-local.conf || echo "/usr/local/lib" >> /etc/ld.so.conf.d/usr-local.conf
    grep -s -q -w "/usr/local/lib64" /etc/ld.so.conf.d/usr-local.conf || echo "/usr/local/lib64" >> /etc/ld.so.conf.d/usr-local.conf
    ldconfig
fi
[ -f $HOME/.tmux.conf ] || touch ~/.tmux.conf
grep -s -q "set-option -g allow-rename off" $HOME/.tmux.conf || echo "set-option -g allow-rename off" >> ~/.tmux.conf
grep -s -q "set-option -g history-limit 10000" $HOME/.tmux.conf || echo "set-option -g history-limit 10000" >> ~/.tmux.conf
EOF
        chmod a+x /usr/local/bin/install-tmux

        compress_binary tmux-${TMUX_VERSION}.txz /usr/local/bin/tmux
    else
        echo "Fail to download tmux"
    fi
else
    echo "Don't define variable for tmux"
fi
