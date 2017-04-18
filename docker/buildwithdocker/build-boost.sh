#!/bin/sh

VERSION=1.63.0

yum install -y -q zlib-devel bzip2-devel p7zip which libicu-devel python-devel

./b2 -j 16 toolset=gcc cxxflags=-std=c++11 stage

