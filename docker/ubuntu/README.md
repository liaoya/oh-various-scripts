# Build Software for Ubuntu with Docker Image

## Start Container

### Xenial (16.04)

```shell
CODENAME=xenial
OUTPUT=/var/www/html/saas/binary/ubuntu-16.04
[ -d $ATTACH ] || mkdir -p mkdir -p $ATTACH
rm -fr $ATTACH/*
docker run -it --rm -h $CODENAME --name $CODENAME -v $OUTPUT:/root/output -e "http_proxy=$http_proxy"  -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' ubuntu:$CODENAME
```

### Zesty (17.04)

```shell
CODENAME=zesty
ATTACH=/root/build/$CODENAME
[ -d $ATTACH ] || mkdir -p mkdir -p $ATTACH
rm -fr $ATTACH/*
docker run -it --rm -h $CODENAME --name $CODENAME -v $ATTACH:/usr/local -e "http_proxy=$http_proxy"  -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' ubuntu:$CODENAME
```

### Artful (17.10)

```shell
mkdir -p mkdir -p /root/build/artful
docker run -it --rm -h artful --name artful -v /root/build/artful:/usr/local -e "http_proxy=$http_proxy"  -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' -e 'LD_RUN_PATH=/usr/local/lib:/usr/local/lib64' ubuntu:artful
```

## Configure APT

```shell
cat <<EOF >> /etc/apt/apt.conf
Acquire::http::proxy "http://10.113.69.79:3128";
Acquire::https::proxy "http://10.113.69.79:3128";
Acquire::ftp::proxy "http://10.113.69.79:3128";
EOF

[ -f /etc/apt/sources.list.origin ] || cp -pr /etc/apt/sources.list /etc/apt/sources.list.origin
sed -i -e 's%archive.ubuntu.com%ftp.jaist.ac.jp/pub/Linux%' /etc/apt/sources.list
sed -i -e 's%security.ubuntu.com%ftp.jaist.ac.jp/pub/Linux%' /etc/apt/sources.list
sed -i -e 's/^deb-src/#deb-src/' /etc/apt/sources.list

apt-get update -qq
apt-get install -y -qq curl openssh-client sshpass build-essential fakeroot
```

## Install Base

