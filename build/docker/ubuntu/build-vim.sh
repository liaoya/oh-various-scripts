#!/bin/sh

# https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source

rm -fr /usr/local/*

apt-get install -y -qq libncurses-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev

VERSION=8.0.1010
curl -L https://github.com/vim/vim/archive/v${VERSION}.tar.gz | tar -xz -C ~

cd ~/vim-${VERSION}
./configure --with-features=huge --enable-pythoninterp --enable-cscope --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) install