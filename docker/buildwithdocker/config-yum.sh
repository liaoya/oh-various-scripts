#!/bin/sh


if [ -n $http_proxy ]; then sed -i "/^installonly_limit/i proxy=$http_proxy" /etc/yum.conf ; fi
if [ -n $http_proxy ]; then yum-config-manager --disable extras ; fi
releasever=$(python -c 'import yum; yb = yum.YumBase(); print yb.conf.yumvar["releasever"]' | tail -n 1)
yum install -y -q https://dl.fedoraproject.org/pub/epel/epel-release-latest-${releasever}.noarch.rpm
yum install -y -q autoconf automake gcc gcc-c++ make deltarpm file xz