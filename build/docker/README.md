# Introduction

Build with Software with Docker container so that I can use up-to-date software.
`-e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' -e 'LD_RUN_PATH=/usr/local/lib:/usr/local/lib6`

## CentOS

```shell
OUTPUT=/var/www/html/saas/binary/rhel6
[[ -d ${OUTPUT} ]] || mkdir -p ${OUTPUT}
docker run -it --rm -h centos6 --name centos6 -v $OUTPUT:/root/output -v $PWD:/root/script -e "OUTPUT=/root/output" -e "SCRIPT=/root/script" -e "http_proxy=$http_proxy" -e "https_proxy=$https_proxy" -e "ftp_proxy=$ftp_proxy" -e "no_proxy=$no_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' centos:6
```

```shell
OUTPUT=/var/www/html/saas/binary/rhel7
[[ -d ${OUTPUT} ]] || mkdir -p ${OUTPUT}
docker run -it --rm -h centos7 --name centos7 -v $OUTPUT:/root/output -v $PWD:/root/script -e "OUTPUT=/root/output" -e "SCRIPT=/root/script" -e "http_proxy=$http_proxy" -e "https_proxy=$https_proxy" -e "ftp_proxy=$ftp_proxy" -e "no_proxy=$no_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' centos:7
```

## Fedora

```shell
OUTPUT=/var/www/html/saas/binary/fedora28
[[ -d ${OUTPUT} ]] || mkdir -p ${OUTPUT}
docker run -it --rm -h fedora28 --name fedora26 -v $OUTPUT:/root/output -v $PWD:/root/script -e "OUTPUT=/root/output" -e "SCRIPT=/root/script" -e "http_proxy=$http_proxy" -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e "no_proxy=$no_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' fedora:28 /bin/bash
```

```shell
OUTPUT=/var/www/html/saas/binary/fedora27
docker run -it --rm -h fedora27 --name fedora27 -v $OUTPUT:/root/output -v $PWD:/root/script -e "OUTPUT=/root/output" -e "SCRIPT=/root/script" -e "http_proxy=$http_proxy" -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e "no_proxy=$no_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' fedora:27 /bin/bash
```

## Ubuntu

### Xenial (16.04)

```shell
CODENAME=xenial
OUTPUT=/var/www/html/saas/binary/ubuntu-$CODENAME
[[ -d ${OUTPUT} ]] || mkdir -p ${OUTPUT}
docker run -it --rm -h $CODENAME --name $CODENAME -v $OUTPUT:/root/output -v $PWD:/root/script -e "OUTPUT=/root/output" -e "SCRIPT=/root/script" -e "http_proxy=$http_proxy"  -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e "no_proxy=$no_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' ubuntu:$CODENAME
```

### Bionic (18.04)

```shell
CODENAME=bionic
OUTPUT=/var/www/html/saas/binary/ubuntu-$CODENAME
[[ -d ${OUTPUT} ]] || mkdir -p ${OUTPUT}
docker run -it --rm -h $CODENAME --name $CODENAME -v $OUTPUT:/root/output -v $PWD:/root/script -e "OUTPUT=/root/output" -e "SCRIPT=/root/script" -e "http_proxy=$http_proxy"  -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e "no_proxy=$no_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' ubuntu:$CODENAME
```
