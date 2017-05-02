#!/bin/sh

yum install -y -q ncurses-devel zlib-devel

MAJOR=2.8
MINOR=1
curl -L https://www.nano-editor.org/dist/v${MAJOR}/nano-${MAJOR}.${MINOR}.tar.xz | tar -Jx -C ~/
cd ~/nano-${MAJOR}.${MINOR}
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) install-strip
cat <<EOF >>/usr/local/bin/install-nano
#!/bin/sh
[ -f ~/.nanorc ] && sed -i "/\/usr\/local\/share\/nano/d" ~/.nanorc
for item in \$(ls -1 /usr/local/share/nano/*.nanorc); do echo "include \$item" >> ~/.nanorc; done
EOF