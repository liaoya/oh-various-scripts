#version=DEVEL
# System authorization information
auth --enableshadow --passalgo=sha512
# Use network installation
url --mirrorlist="https://mirrors.fedoraproject.org/metalink?repo=fedora-$releasever&arch=$basearch" --proxy="http://10.113.69.101:3128"
# Use graphical install
graphical
# Run the Setup Agent on first boot
firstboot --enable
ignoredisk --only-use=vda
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=static --device=ens3 --gateway=10.113.4.1 --ip=10.113.5.157 --nameserver=192.135.82.76,10.182.244.44,146.56.237.50 --netmask=255.255.252.0 --noipv6 --activate
network  --hostname=Fedora25
# Root password
rootpw --iscrypted $6$76PSI93ypGVTVGcd$7nz9rYEjpdKF9dKwF6KK9Uxm/xgn3aTL0M0kHYzjKHyw4Whjnj3Uq33rDy5qVoYBR3HHNRP2h4EtghlF1S7lu/
# System services
services --enabled="chronyd"
# System timezone
timezone Asia/Shanghai --isUtc
# System bootloader configuration
bootloader --location=mbr --boot-drive=vda
autopart --type=lvm
# Partition clearing information
clearpart --none --initlabel

%packages
@^minimal-environment
chrony

%end

%addon com_redhat_kdump --disable --reserve-mb='128'

%end

%anaconda
pwpolicy root --minlen=0 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy user --minlen=0 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=0 --minquality=1 --notstrict --nochanges --emptyok
%end
