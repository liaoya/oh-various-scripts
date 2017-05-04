# Introduction #

Build with CentOS 7 Docker container so that I can use up-to-date software.
 
     docker run -it --rm -h fedora --name fedora -v /root/mingw64:/usr/local/mingw64 -e "http_proxy=$http_proxy" -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e 'PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib' fedora:25 /bin/bash