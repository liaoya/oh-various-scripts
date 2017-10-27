#!/bin/sh

# http://www.hergert.me/blog/2015/07/29/caching-updates.html

sed -i "/^proxy/d" /etc/dnf/dnf.conf
sed -i "/^installonly_limit/i proxy=http://10.113.69.79:3128" /etc/dnf/dnf.conf
#sed -i "/^installonly_limit/i fastestmirror=true" /etc/dnf/dnf.conf
sed -i "s/^metalink.*repo=fedora-\$.*/#&/g" /etc/yum.repos.d/fedora.repo
sed -i "s/^#baseurl=http.*basearch\/os\//&\nbaseurl=http:\/\/ftp\.jaist\.ac\.jp\/pub\/Linux\/Fedora\/releases\/\$releasever\/Everything\/\$basearch\/os\//g" /etc/yum.repos.d/fedora.repo
sed -i "s/^metalink.*repo=updates-released-f\$.*/#&/g" /etc/yum.repos.d/fedora-updates.repo
sed -i "s/^#baseurl=http.*\$basearch\//&\nbaseurl=http:\/\/ftp\.jaist\.ac\.jp\/pub\/Linux\/Fedora\/updates\/\$releasever\/\$basearch\//g" /etc/yum.repos.d/fedora-updates.repo
dnf install -y -q autoconf automake libtool gcc gcc-c++ make file which pxz pigz lbzip2 unzip bzip2 xz lzip