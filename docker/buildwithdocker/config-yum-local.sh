#!/bin/sh

if [ -n $http_proxy ]; then sed -i "/^installonly_limit/i proxy=$http_proxy" /etc/yum.conf ; fi && \
echo "10.113.69.25   localyummirror" >> /etc/hosts && \
rm -f /etc/yum.repos.d/* && \
(cd /etc/yum.repos.d/; curl --noproxy "*" -s -k -O https://localyummirror/mirror/repos/centos/centos-local.repo) && \
sed -i "s/enabled=0/enabled=1/g" /etc/yum.repos.d/*