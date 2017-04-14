#!/bin/sh

sed -i "/^installonly_limit/i proxy=http://10.113.69.101:3128" /etc/yum.conf
yum install -y -q yum-plugin-fastestmirror epel-release
echo "include_only=ftp.jaist.ac.jp" >> /etc/yum/pluginconf.d/fastestmirror.conf
yum install -y -q autoconf automake libtool gcc gcc-c++ make file which