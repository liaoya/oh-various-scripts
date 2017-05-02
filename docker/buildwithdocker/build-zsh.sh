#!/bin/sh

yum install -y -q ncurses-devel bison

VERSION=5.3.1
curl -L https://sourceforge.net/projects/zsh/files/zsh/${VERSION}/zsh-${VERSION}.tar.xz/download -o zsh-${VERSION}-tar.xz | tar -Jx -C ~/
cd ~/zsh-${VERSION}
./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) all
make install-strip