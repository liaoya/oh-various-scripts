#!/bin/sh

[ -f /etc/NetworkManager/NetworkManager.conf ] && sed -i '/^plugins=ifcfg-rh/a dns=none' /etc/NetworkManager/NetworkManager.conf
sed -i '/PEER/d' /etc/sysconfig/network-scripts/ifcfg-e*
sed -i '/HWADDR/d' /etc/sysconfig/network-scripts/ifcfg-e*
sed -i '/UUID/d' /etc/sysconfig/network-scripts/ifcfg-e*
#sed -i 's/BOOTPROTO=dhcp/BOOTPROTO=none/g' /etc/sysconfig/network-scripts/ifcfg-*
rm -f /etc/udev/rules.d/70-persistent-net.rules
