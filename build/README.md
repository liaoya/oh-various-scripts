# Build Scripts

Docker is used to build most of the softwares, but some software need virtual machine (most Vagrant) environment.

- Emacs
- OpenvSwitch

## Proxy

### CentOS

```shell
YUM_PROXY=http://10.113.69.101:3128
YUM_MIRROR_SERVER="http://ftp.jaist.ac.jp"
YUM_MIRROR_EPEL_PATH="/pub/Linux/Fedora"
YUM_MIRROR_PATH="/pub/Linux/CentOS"

sed -i "/^proxy/Id" /etc/yum.conf
sed -i "/^installonly_limit/i deltarpm=0" /etc/yum.conf
[[ -f /etc/yum.conf && -n $YUM_PROXY ]] && sed -i "/^installonly_limit/i proxy=$YUM_PROXY" /etc/yum.conf

for elem in $(ls -1 /etc/yum.repos.d/CentOS*.repo); do [ -f ${elem}.origin ] || cp ${elem} ${elem}.origin; done
for elem in $(ls -1 /etc/yum.repos.d/CentOS*.repo); do 
    grep -s -q -e "^mirrorlist=" ${elem} && sed -i -e "s/^mirrorlist=/#mirrorlist=/g" ${elem}
    grep -s -q -e "^#baseurl=" ${elem} && grep -s -q -e "^baseurl=" ${elem} && sed -i -e "/^baseurl=/d" ${elem};
    grep -s -q -e "^#baseurl=" ${elem} && sed -i -e "s/^#baseurl=/baseurl=/g" ${elem}
    sed -i -e "s%^baseurl=.*%#&\n&%g" ${elem}
    sed -i -e "s%^baseurl=http://mirror.centos.org/centos%baseurl=${YUM_MIRROR_SERVER}${YUM_MIRROR_PATH}%g" ${elem}
done
yum install -y -q epel-release

for elem in $(ls -1 /etc/yum.repos.d/epel*.repo); do [ -f ${elem}.origin ] || cp ${elem} ${elem}.origin; done
for elem in $(ls -1 /etc/yum.repos.d/epel*.repo); do
    grep -s -q -e "^mirrorlist=" ${elem} && sed -i -e "s/^mirrorlist=/#mirrorlist=/g" ${elem}
    grep -s -q -e "^#baseurl=" ${elem} && grep -s -q -e "^baseurl=" ${elem} && sed -i -e "/^baseurl=/d" ${elem};
    grep -s -q -e "^#baseurl=" ${elem} && sed -i -e "s/^#baseurl=/baseurl=/g" ${elem}
    sed -i -e "s%^baseurl=.*%#&\n&%g" ${elem}
    sed -i -e "s%^baseurl=http://download.fedoraproject.org/pub%baseurl=${YUM_MIRROR_SERVER}${YUM_MIRROR_EPEL_PATH}%g" ${elem}
done
```

### Fedora

```shell
YUM_PROXY=http://10.113.69.101:3128
DNF_MIRROR_SERVER="http://ftp.jaist.ac.jp"
DNF_MIRROR_PATH="/pub/Linux/Fedora"

[ -f /etc/dnf/dnf.conf ] && sed -i "/^proxy/Id" /etc/dnf/yum.conf
sed -i "/^installonly_limit/i deltarpm=0" /etc/dnf/dnf.conf
[[ -f /etc/dnf/dnf.conf && -n $YUM_PROXY ]] && sed -i "/^installonly_limit/i proxy=$YUM_PROXY" /etc/dnf/dnf.conf

for item in $(ls -1 /etc/yum.repos.d/fedora*.repo); do [ -f ${item}.origin ] || cp ${item} ${item}.origin; done
for item in $(ls -1 /etc/yum.repos.d/fedora*.repo); do
    grep -s -q -e "^metalink=" ${elem} && sed -i -e "s/^metalink=/#metalink=/g" ${elem}
    grep -s -q -e "^#baseurl=" ${elem} && grep -s -q -e "^baseurl=" ${elem} && sed -i -e "/^baseurl=/d" ${elem};
    grep -s -q -e "^#baseurl=" ${elem} && sed -i -e "s/^#baseurl=/baseurl=/g" ${elem}
    sed -i -e "s%^baseurl=.*%#&\n&%g" ${elem}
    sed -i -e "s%^baseurl=http://download.fedoraproject.org/pub/fedora/linux%baseurl=${DNF_MIRROR_SERVER}${DNF_MIRROR_PATH}%g" ${elem}
done
```

### Ubuntu

```shell
APT_PROXY=http://10.113.69.101:3128

[ -f /etc/apt/apt.conf ] && sed -i "/::proxy/Id" /etc/apt/apt.conf
[ -f /etc/apt/apt.conf.d/01proxy ] && rm -f /etc/apt/apt.conf.d/01proxy
cat <<EOF >> /etc/apt/apt.conf.d/01proxy
Acquire::http::proxy "$APT_PROXY";
Acquire::https::proxy "$APT_PROXY";
EOF

APT_MIRROR_SERVER="http://ftp.jaist.ac.jp"
APT_MIRROR_PATH="/pub/Linux/ubuntu"
[ -f /etc/apt/sources.list.origin ] || cp -pr /etc/apt/sources.list /etc/apt/sources.list.origin
sed -i -e "s%http://.*archive.ubuntu.com%$APT_MIRROR_SERVER$APT_MIRROR_PATH%" -e "s%http://security.ubuntu.com%$APT_MIRROR_SERVER$APT_MIRROR_PATH%" /etc/apt/sources.list
sed -i -e 's/^deb-src/#deb-src/' /etc/apt/sources.list

apt-get update -qq
```
