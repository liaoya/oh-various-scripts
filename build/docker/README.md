# Introduction

Build with Software with Docker container so that I can use up-to-date software.
`-e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' -e 'LD_RUN_PATH=/usr/local/lib:/usr/local/lib6`

## CentOS

```shell
OUTPUT=/var/www/html/saas/binary/rhel6
SCRIPT=/work/build
docker run -it --rm -h centos6 --name centos6 -v $OUTPUT:/root/output -v $SCRIPT:/root/script -e "OUTPUT=/root/output" -e "SCRIPT=/root/script" -e "http_proxy=$http_proxy"  -e "https_proxy=$https_proxy" -e "ftp_proxy=$ftp_proxy" -e "no_proxy=$no_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' centos:6
```

```shell
OUTPUT=/var/www/html/saas/binary/rhel7
SCRIPT=/work/build
docker run -it --rm -h centos7 --name centos7 -v $OUTPUT:/root/output -v $SCRIPT:/root/script -e "OUTPUT=/root/output" -e "SCRIPT=/root/script" -e "http_proxy=$http_proxy"  -e "https_proxy=$https_proxy" -e "ftp_proxy=$ftp_proxy" -e "no_proxy=$no_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' centos:7
```

```shell
OUTPUT=/var/www/html/saas/binary/rhel6
SCRIPT=/work/build
docker run -it --rm -h centos6 --name centos6 -v $OUTPUT:/root/output -v $SCRIPT:/root/script -e "OUTPUT=/root/output" -e "SCRIPT=/root/script" -e "http_proxy=$http_proxy"  -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e "no_proxy=$no_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' centos:6
```

## Fedora

```shell
OUTPUT=/var/www/html/saas/binary/fedora26
SCRIPT=/work/build
docker run -it --rm -h fedora26 --name fedora26 -v $OUTPUT:/root/output -v $SCRIPT:/root/script -e "OUTPUT=/root/output" -e "SCRIPT=/root/script" -e "http_proxy=$http_proxy"  -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e "no_proxy=$no_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' fedora:26 /bin/bash
```

## Ubuntu

### Xenial (16.04)

```shell
CODENAME=xenial
OUTPUT=/var/www/html/saas/binary/ubuntu-16.04
SCRIPT=/work/build
docker run -it --rm -h $CODENAME --name $CODENAME -v $OUTPUT:/root/output -v $SCRIPT:/root/script -e "OUTPUT=/root/output" -e "SCRIPT=/root/script" -e "http_proxy=$http_proxy"  -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e "no_proxy=$no_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' ubuntu:$CODENAME
```

### Artful (17.10)

```shell
CODENAME=artful
OUTPUT=/var/www/html/saas/binary/ubuntu-17.10
SCRIPT=/work/build
docker run -it --rm -h $CODENAME --name $CODENAME -v $OUTPUT:/root/output -v $SCRIPT:/root/script -e "OUTPUT=/root/output" -e "SCRIPT=/root/script" -e "http_proxy=$http_proxy"  -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e "no_proxy=$no_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' ubuntu:$CODENAME
```
