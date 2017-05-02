#!/bin/sh

sed -i "/^installonly_limit/i proxy=http://10.113.69.101:3128" /etc/dnf/dnf.conf
#sed -i "/^installonly_limit/i fastestmirror=true" /etc/dnf/dnf.conf
sed -i "/^installonly_limit/i deltarpm=true" /etc/dnf/dnf.conf
echo "include_only=ftp.jaist.ac.jp" >> /etc/yum/pluginconf.d/fastestmirror.conf
dnf install -y -q autoconf automake libtool gcc gcc-c++ make file which pxz pigz lbzip2

# export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib