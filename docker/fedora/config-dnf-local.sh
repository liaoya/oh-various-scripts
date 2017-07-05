#!/bin/sh

# http://www.hergert.me/blog/2015/07/29/caching-updates.html

sed -i "/^proxy/d" /etc/yum.conf
sed -i "/^installonly_limit/i proxy=http://10.113.69.79:3128" /etc/dnf/dnf.conf
#sed -i "/^installonly_limit/i fastestmirror=true" /etc/dnf/dnf.conf
dnf install -y -q autoconf automake libtool gcc gcc-c++ make file which pxz pigz lbzip2 unzip bzip2 xz lzip