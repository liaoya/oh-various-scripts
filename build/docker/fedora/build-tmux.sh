#!/bin/sh

dnf install -y -q ncurses-devel libevent-devel

VERSION=2.6
curl -L https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz | tar -xz -C ~

cd ~/tmux-${VERSION}
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) install-strip

cat <<EOF >>/usr/local/bin/install-tmux
#!/bin/sh
[ -f ~/.tmux.conf ] || touch ~/.tmux.conf
grep -s -q "set-option -g allow-rename off" ~/.tmux.conf || echo "set-option -g allow-rename off" >> ~/.tmux.conf
EOF

chmod a+x /usr/local/bin/install-tmux
