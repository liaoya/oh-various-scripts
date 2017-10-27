#!/bin/sh

sed -i "/^proxy/d" /etc/yum.conf
sed -i "/^installonly_limit/i proxy=http://10.113.69.101:3128" /etc/yum.conf
echo "include_only=ftp.jaist.ac.jp" >> /etc/yum/pluginconf.d/fastestmirror.conf
sed -i "/^installonly_limit/i deltarpm=0" /etc/yum.conf

for elem in $(ls -1 /etc/yum.repos.d/CentOS*.repo); do [ -f ${elem}.origin ] || cp ${elem} ${elem}.origin; done
for elem in $(ls -1 /etc/yum.repos.d/CentOS*.repo); do sed -i -e "s/^mirrorlist/#&/g" -e "s%^#baseurl=http://mirror.centos.org/centos%baseurl=http://ftp.jaist.ac.jp/pub/Linux/CentOS%g" ${elem}; done
yum install -y -q epel-release deltarpm

[ -f /etc/yum.repos.d/epel.repo.origin ] || cp /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.origin
sed -i -e "s/^metalink/#&/g" -e "s/^mirrorlist/#&/g" -e "s%^#baseurl=http://download.fedoraproject.org/pub%baseurl=http://ftp.jaist.ac.jp/pub/Linux/Fedora%g" /etc/yum.repos.d/epel.repo

(cd /etc/yum.repos.d/; curl -s -L -O http://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo)

# if [ -n $http_proxy ]; then yum-config-manager --disable extras ; fi
yum install -y -q autoconf automake libtool gcc gcc-c++ make file which pxz pigz lbzip2 unzip bzip2 xz lzip openssh-clients

# export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
