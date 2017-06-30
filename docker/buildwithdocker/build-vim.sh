#!/bin/sh

yum install -y -q ncurses-devel \
  ruby ruby-devel lua lua-devel luajit \
  luajit-devel ctags git python python-devel \
  python3 python3-devel tcl-devel \
  perl perl-devel perl-ExtUtils-ParseXS \
  perl-ExtUtils-XSpp perl-ExtUtils-CBuilder \
  perl-ExtUtils-Embed \
  gtk2-devel gtk3-devel \
  libacl-devel cscope

VERSION=8.0.0642
curl -L https://github.com/vim/vim/archive/v${VERSION}.tar.gz | tar -xz -C ~

cd ~/vim-${VERSION}
./configure --with-features=huge --enable-pythoninterp --enable-cscope --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
make -j $(nproc) install

# ./configure --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux --with-features=huge --enable-multibyte --enable-rubyinterp --enable-pythoninterp --enable-python3interp --enable-perlinterp --enable-luainterp --enable-cscope --enable-gui=gtk3