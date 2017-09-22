# Build Software for Ubuntu with Docker Image

## Start Container

### Xenial (16.04)

```shell
CODENAME=xenial
OUTPUT=/var/www/html/saas/binary/ubuntu-16.04
docker run -it --rm -h $CODENAME --name $CODENAME -v $OUTPUT:/root/output -e "http_proxy=$http_proxy"  -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' ubuntu:$CODENAME
```

### Zesty (17.04)

```shell
CODENAME=zesty
OUTPUT=/var/www/html/saas/binary/ubuntu-17.04
docker run -it --rm -h $CODENAME --name $CODENAME -v $OUTPUT:/root/output -e "http_proxy=$http_proxy"  -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' ubuntu:$CODENAME
```

### Artful (17.10)

```shell
CODENAME=artful
OUTPUT=/var/www/html/saas/binary/ubuntu-17.10
docker run -it --rm -h $CODENAME --name $CODENAME -v $OUTPUT:/root/output -e "http_proxy=$http_proxy"  -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' ubuntu:$CODENAME
```

## Configure APT

```shell
[ -f /etc/apt/apt.conf ] && sed -i "/::proxy/Id" /etc/apt/apt.conf
[ -f /etc/apt/apt.conf.d/01proxy ] && rm -f /etc/apt/apt.conf.d/01proxy
cat <<EOF >> /etc/apt/apt.conf.d/01proxy
Acquire::http::proxy "http://10.113.69.101:3128";
Acquire::https::proxy "http://10.113.69.101:3128";
Acquire::ftp::proxy "http://10.113.69.101:3128";
EOF

[ -f /etc/apt/sources.list.origin ] || cp -pr /etc/apt/sources.list /etc/apt/sources.list.origin
sed -i -e 's%archive.ubuntu.com%ftp.jaist.ac.jp/pub/Linux%' /etc/apt/sources.list
sed -i -e 's%security.ubuntu.com%ftp.jaist.ac.jp/pub/Linux%' /etc/apt/sources.list
sed -i -e 's/^deb-src/#deb-src/' /etc/apt/sources.list

apt-get update -qq
apt-get install -y -qq curl openssh-client sshpass build-essential fakeroot
```

## Install Base

