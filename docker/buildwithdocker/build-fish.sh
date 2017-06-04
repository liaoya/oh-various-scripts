#!/bin/bash

yum install -y -q ncurses-devel pcre2-devel
releasever=$(python -c 'import yum; yb = yum.YumBase(); print yb.conf.yumvar["releasever"]' | tail -n 1)

if [ $releasever = "7" ]; then
    VERSION=2.5.0
else
    VERSION=2.4.0
fi
curl -L https://github.com/fish-shell/fish-shell/releases/download/${VERSION}/fish-${VERSION}.tar.gz | tar -xz -C ~/
cd ~/fish-${VERSION}
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) all
make install
for item in $(ls -1 /usr/local/bin/fish*); do file $item | grep -q -s "not stripped" && strip $item; done

cat <<'EOF' >> /usr/local/bin/installfish.sh
if [ $UID -eq 0 ]; then
    echo /usr/local/bin/fish | tee -a /etc/shells
    chcon -t shell_exec_t /usr/local/bin/fish
fi
EOF
