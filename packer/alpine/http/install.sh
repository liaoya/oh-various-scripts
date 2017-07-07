#!/bom/sh

setup-keymap us us
setup-hostname -n alpine-virt
echo -e "eth0\ndhcp\nno\n" | setup-interfaces
/etc/init.d/networking --quiet start &
setup-dns -d cn.oracle.com 10.182.244.34
setup-timezone -z Asia/Shanghai
setup-sshd -c openssh
/etc/init.d/hostname --quiet restart
setup-apkrepos -1
setup-ntp -c openntpd
echo -e "y" | setup-disk -m sys -s 0 -L /dev/vda
