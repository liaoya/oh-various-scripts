# Introduction #

Build with Software with Docker container so that I can use up-to-date software.
`-e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' -e 'LD_RUN_PATH=/usr/local/lib:/usr/local/lib6`

## CentOS

```shell
OUTPUT=/var/www/html/saas/binary/rhel7
SCRIPT=/work/build
docker run -it --rm -h centos7 --name centos7 -v $OUTPUT:/root/output -v $SCRIPT:/root/script -e "OUTPUT=/root/output" -e "SCRIPT=/root/script" -e "http_proxy=$http_proxy"  -e "https_proxy=$https_proxy" -e "ftp_proxy=$ftp_proxy" -e "no_proxy=$no_proxy" centos:7
```

```shell
OUTPUT=/var/www/html/saas/binary/rhel6
SCRIPT=/work/build
docker run -it --rm -h centos6 --name centos6 -v /root/build/centos6:/usr/local -e "http_proxy=$http_proxy"  -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' -e 'LD_RUN_PATH=/usr/local/lib:/usr/local/lib64' centos:6
```
