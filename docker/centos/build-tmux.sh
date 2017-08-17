#!/bin/bash

releasever=$(python -c 'import yum; yb = yum.YumBase(); print yb.conf.yumvar["releasever"]' | tail -n 1)
yum install -y -q ncurses-devel

VERSION=2.5
curl -L https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz | tar -xz -C ~
if [ $releasever = "7" ]; then
    yum install -q -y libevent-devel
else
    LIBEVENT_VERSION=2.0.22
    curl -L https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}-stable/libevent-${LIBEVENT_VERSION}-stable.tar.gz | tar -xz -C ~
    cd ~/libevent-${LIBEVENT_VERSION}-stable
    ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
    make -j $(nproc) all
    make install-strip
fi

cd ~/tmux-${VERSION}
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) install-strip

cat <<EOF >>/usr/local/bin/install-tmux
#!/bin/sh
if [ $UID -eq 0 ]; then
    [ -f /etc/ld.so.conf.d/usr-local.conf ] || touch /etc/ld.so.conf.d/usr-local.conf
    grep -s -q -w "/usr/local/lib" /etc/ld.so.conf.d/usr-local.conf || echo "/usr/local/lib" >> /etc/ld.so.conf.d/usr-local.conf
    grep -s -q -w "/usr/local/lib64" /etc/ld.so.conf.d/usr-local.conf || echo "/usr/local/lib64" >> /etc/ld.so.conf.d/usr-local.conf
    ldconfig
fi
[ -f ~/.tmux.conf ] || touch ~/.tmux.conf
grep -s -q "set-option -g allow-rename off" ~/.tmux.conf || echo "set-option -g allow-rename off" >> ~/.tmux.conf
grep -s -q "set-option -g history-limit 10000" ~/.tmux.conf || echo "set-option -g history-limit 10000" >> ~/.tmux.conf
EOF

chmod a+x /usr/local/bin/install-tmux