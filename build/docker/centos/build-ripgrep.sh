#!/bin/sh

# Rust is required for building

VERSION=0.6.0
curl -L https://github.com/BurntSushi/ripgrep/archive/${VERSION}.tar.gz | tar -xz -C ~/
cd ~/ripgrep-${VERSION}
