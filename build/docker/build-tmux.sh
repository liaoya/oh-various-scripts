#!/bin/bash
#shellcheck disable=SC1090,SC2164

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
[[ -f ${THIS_DIR}/../env.sh ]] && source ${THIS_DIR}/../env.sh

TMUX_VERSION=$(curl -s "https://api.github.com/repos/tmux/tmux/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
TMUX_URL=https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
TMUX_SRCDIR=tmux-${TMUX_VERSION}

if [[ -n $TMUX_VERSION && -n $TMUX_URL && -n $TMUX_SRCDIR ]]; then
    prepare_build "tmux"

    if [ -d $HOME/$TMUX_SRCDIR ]; then
        clear_usrlocal

        if [[ -f /etc/redhat-release && ! -f /etc/fedora-release ]]; then
            releasever=$(python -c 'import yum; yb = yum.YumBase(); print yb.conf.yumvar["releasever"]' | tail -n 1)
            if [ $releasever == "6" ]; then
                LIBEVENT_VERSION=2.1.8
                download_source https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}-stable/libevent-${LIBEVENT_VERSION}-stable.tar.gz
                [ -d $HOME/libevent-${LIBEVENT_VERSION}-stable ] && rm -fr $HOME/libevent-${LIBEVENT_VERSION}-stable
                tar -C $HOME -xf $HOME/libevent-${LIBEVENT_VERSION}-stable.tar.gz
                cd $HOME/libevent-${LIBEVENT_VERSION}-stable
                ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
                make -s -j "$(nproc)" all
                make install-strip
            fi
        fi

        cd $HOME/$TMUX_SRCDIR
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j "$(nproc)" install-strip
# https://stackoverflow.com/questions/27920806/how-to-avoid-heredoc-expanding-variables
        cat <<'EOF' > /usr/local/bin/install-tmux.sh
#!/bin/bash
if [ $UID -eq 0 ]; then
    [ -f /etc/ld.so.conf.d/usr-local.conf ] || touch /etc/ld.so.conf.d/usr-local.conf
    grep -s -q -w "/usr/local/lib" /etc/ld.so.conf.d/usr-local.conf || echo "/usr/local/lib" >> /etc/ld.so.conf.d/usr-local.conf
    grep -s -q -w "/usr/local/lib64" /etc/ld.so.conf.d/usr-local.conf || echo "/usr/local/lib64" >> /etc/ld.so.conf.d/usr-local.conf
    ldconfig
    [[ -n $SYSCONFDIR ]] || SYSCONFDIR="/etc"
    CONF=$SYSCONFDIR/tmux.conf
else
    CONF=$HOME/.tmux.conf
fi

[ -f $CONF ] || touch $CONF
grep -s -q "set-option -g allow-rename off" $CONF || echo "set-option -g allow-rename off" >> $CONF
grep -s -q "set-option -g history-limit 10000" $CONF || echo "set-option -g history-limit 10000" >> $CONF
EOF
        chmod a+x /usr/local/bin/install-tmux.sh

        compress_binary tmux-${TMUX_VERSION} /usr/local/bin/tmux
    else
        echo "Fail to download tmux"
    fi
else
    echo "Don't define variable for tmux"
fi
