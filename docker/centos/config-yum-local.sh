#!/bin/sh

sed -i "/^proxy/d" /etc/yum.conf
sed -i "/^installonly_limit/i proxy=http://10.113.69.79:3128" /etc/yum.conf
#echo "include_only=ftp.jaist.ac.jp" >> /etc/yum/pluginconf.d/fastestmirror.conf
sed -i "/^installonly_limit/i deltarpm=0" /etc/yum.conf
#for item in $(ls -1 /etc/yum.repos.d/CentOS*.repo); do [ -f $item.origin ] || cp -pr $item $item.origin; done
sed -i "s/^mirrorlist/#&/g" /etc/yum.repos.d/CentOS*.repo
sed -i "s/^#baseurl=http:\/\/mirror.centos.org\/centos/baseurl=http:\/\/ftp\.jaist\.ac\.jp\/pub\/Linux\/CentOS/g" /etc/yum.repos.d/CentOS*.repo
yum install -y -q epel-release deltarpm yum-utils
sed -i "s/^metalink/#&/g" /etc/yum.repos.d/epel.repo
sed -i "s/^mirrorlist/#&/g" /etc/yum.repos.d/epel.repo
sed -i "s/^#baseurl=http:\/\/download.fedoraproject.org\/pub/baseurl=http:\/\/ftp\.jaist\.ac\.jp\/pub\/Linux\/Fedora/g" /etc/yum.repos.d/epel.repo
# if [ -n $http_proxy ]; then yum-config-manager --disable extras ; fi
yum install -y -q autoconf automake libtool gcc gcc-c++ make file which pxz pigz lbzip2 unzip bzip2 xz lzip

# export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib