# Introduction #

Build with CentOS 7 Docker container so that I can use up-to-date software.
 
     docker run -it --rm -h centos7 --name centos7 -v /root/build:/usr/local -e "http_proxy=http://cn-proxy.jp.oracle.com:80" -e "https_proxy=http://cn-proxy.jp.oracle.com:80" centos:7