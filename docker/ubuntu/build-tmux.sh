#!/bin/sh

rm -fr /usr/local/*

apt-get install -y -qq libevent-dev libncurses-dev

VERSION=2.5
curl -L https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz | tar -xz -C ~
cd ~/tmux-${VERSION}
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) install-strip

cat <<EOF >>/usr/local/bin/install-tmux
#!/bin/sh
if [ $UID -eq 0 ]; then
    apt-get update -qq
    apt-get install -qq -y libpcre2-32-0
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

tar -C /usr/local -cf ~/output/tmux-$VERSION.txz .