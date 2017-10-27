#!/bin/sh

yum install -y -q zlib-devel bzip2-devel p7zip libicu-devel python-devel openmpi-devel

VERSION=1.65.1
FILENAME=boost_$(echo $VERSION | sed -e 's%\.%_%g').7z
curl -L https://dl.bintray.com/boostorg/release/${VERSION}/source/${FILENAME}
7za x ${FILENAME}
cd $(basename -s .7z ${FILENAME})
./bootstrap.sh
./b2 -j $(nproc) toolset=gcc cxxflags="-std=c++11"" stage

# https://gist.github.com/jimporter/10442880
# ./bootstrap.sh --with-toolset=clang
# ./b2 toolset=clang cxxflags="-std=c++11 -stdlib=libc++" linkflags="-stdlib=libc++"

