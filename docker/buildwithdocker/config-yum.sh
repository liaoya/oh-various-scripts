#!/bin/sh

if [ -n $http_proxy ]; then sed -i "/^installonly_limit/i proxy=$http_proxy" /etc/yum.conf ; fi
if [ -n $http_proxy ]; then yum-config-manager --disable extras ; fi
releasever=$(python -c 'import yum; yb = yum.YumBase(); print yb.conf.yumvar["releasever"]' | tail -n 1)
yum install -y -q https://dl.fedoraproject.org/pub/epel/epel-release-latest-${releasever:0:1}.noarch.rpm
yum install -y -q autoconf automake libtool gcc gcc-c++ make file which pxz pigz lbzip2 unzip