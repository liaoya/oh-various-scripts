#!/bin/sh

yum install -y -q wxGTK3-devel cmake sqlite-devel libssh-devel clang-devel hunspell-devel lldb-devel

ln -s /usr/bin/wx-config-3.0 /usr/bin/wx-config

cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCL_PREFIX=/usr/local
make -j $(nproc) all