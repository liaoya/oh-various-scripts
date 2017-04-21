#!/bin/sh

yum install -y -q zlib-devel bzip2-devel p7zip libicu-devel python-devel openmpi-devel

VERSION=1_64_0
curl -L https://sourceforge.net/projects/boost/files/boost/$(echo $VERSION| sed 's/_/\./g')/boost_${VERSION}.7z/download -o boost_${VERSION}.7z
7za x boost_${VERSION}.7z
cd boost_${VERSION}
./bootstrap.sh
./b2 -j $(nproc) toolset=gcc cxxflags="-std=c++11"" stage

# https://gist.github.com/jimporter/10442880
# ./bootstrap.sh --with-toolset=clang
# ./b2 toolset=clang cxxflags="-std=c++11 -stdlib=libc++" linkflags="-stdlib=libc++"

