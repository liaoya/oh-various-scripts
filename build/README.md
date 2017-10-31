# Build Scripts

Docker is used to build most of the softwares, but some software need virtual machine (most Vagrant) environment.

- Emacs
- OpenvSwitch


## Proxy

### CentOS

```shell
sed -i "/^proxy/Id" /etc/yum.conf
sed -i "/^installonly_limit/i proxy=http://10.113.69.101:3128" /etc/yum.conf
sed -i "/^installonly_limit/i deltarpm=0" /etc/yum.conf

for elem in $(ls -1 /etc/yum.repos.d/CentOS*.repo); do [ -f ${elem}.origin ] || cp ${elem} ${elem}.origin; done
for elem in $(ls -1 /etc/yum.repos.d/CentOS*.repo); do sed -i -e "s/^mirrorlist/#&/g" -e "s%^#baseurl=http://mirror.centos.org/centos%baseurl=http://ftp.jaist.ac.jp/pub/Linux/CentOS%g" ${elem}; done

yum install -y -q yum-plugin-fastestmirror epel-release deltarpm libevent yum-utils
echo "include_only=ftp.jaist.ac.jp" >> /etc/yum/pluginconf.d/fastestmirror.conf

[ -f /etc/yum.repos.d/epel.repo.origin ] || cp /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.origin
sed -i -e "s/^metalink/#&/g" -e "s/^mirrorlist/#&/g" -e "s%^#baseurl=http://download.fedoraproject.org/pub%baseurl=http://ftp.jaist.ac.jp/pub/Linux/Fedora%g" /etc/yum.repos.d/epel.repo
```

### Fedora

### Ubuntu

```shell
sed -i "/^installonly_limit/i proxy=http://10.113.69.79:3128" /etc/dnf/dnf.conf
sed -i "/^installonly_limit/i deltarpm=0" /etc/dnf/dnf.conf

for item in $(ls -1 /etc/yum.repos.d/fedora*.repo); do [ -f ${item}.origin ] || cp ${item} ${item}.origin; done
sed -i "s/^metalink.*repo=fedora-\$.*/#&/g" /etc/yum.repos.d/fedora.repo
sed -i "s/^#baseurl=http.*basearch\/os\//&\nbaseurl=http:\/\/ftp\.jaist\.ac\.jp\/pub\/Linux\/Fedora\/releases\/\$releasever\/Everything\/\$basearch\/os\//g" /etc/yum.repos.d/fedora.repo
sed -i "s/^metalink.*repo=updates-released-f\$.*/#&/g" /etc/yum.repos.d/fedora-updates.repo
sed -i "s/^#baseurl=http.*\$basearch\//&\nbaseurl=http:\/\/ftp\.jaist\.ac\.jp\/pub\/Linux\/Fedora\/updates\/\$releasever\/\$basearch\//g" /etc/yum.repos.d/fedora-updates.repo
```
