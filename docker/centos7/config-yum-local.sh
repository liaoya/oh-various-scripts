#!/bin/sh

sed -i "/^proxy/d" /etc/yum.conf
sed -i "/^installonly_limit/i proxy=http://10.113.69.79:3128" /etc/yum.conf
echo "include_only=ftp.jaist.ac.jp" >> /etc/yum/pluginconf.d/fastestmirror.conf
yum install -y -q epel-release
# if [ -n $http_proxy ]; then yum-config-manager --disable extras ; fi
yum install -y -q autoconf automake libtool gcc gcc-c++ make file which pxz pigz lbzip2 unzip bzip2 xz lzip

# export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib