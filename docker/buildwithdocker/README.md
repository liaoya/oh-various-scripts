# Introduction #

Build with CentOS 7 Docker container so that I can use up-to-date software.
 
     docker run -it --rm -h centos7 --name centos7 -v /root/build:/usr/local -e "http_proxy=$http_proxy"  -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' -e 'LD_RUN_PATH=/usr/local/lib:/usr/local/lib64' centos:7

Build with CentOS 6 Docker container so that I can use up-to-date software.
 
     docker run -it --rm -h centos6 --name centos6 -v /root/build:/usr/local -e "http_proxy=$http_proxy"  -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' -e 'LD_RUN_PATH=/usr/local/lib:/usr/local/lib64' centos:6