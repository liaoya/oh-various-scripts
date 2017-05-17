#!/bin/sh

VERSION=2.4
releasever=$(python -c 'import yum; yb = yum.YumBase(); print yb.conf.yumvar["releasever"]' | tail -n 1)
yum install -y -q ncurses-devel
curl -L https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz | tar -xz -C ~
if [ $releasever = "7" ]; then
    yum install -q -y libevent-devel
    cd ~/tmux-${VERSION}
    ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
    make -j $(nproc) install-strip
else
    LIBEVENT_VERSION=2.0.22
    curl -L https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}-stable/libevent-${LIBEVENT_VERSION}-stable.tar.gz | tar -xz
    cd ~/libevent-${LIBEVENT_VERSION}-stable
    ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
    make -j $(nproc) all
    make install-strip
    cd ~/tmux-${VERSION}
    ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
    make -j $(nproc) install-strip
    echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local.conf
    tar -Jcf ~/lftp-${VERSION}.txz -C / usr/local/. etc/ld.so.conf.d/usr-local.conf
fi

