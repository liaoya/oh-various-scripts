# How to build in Fedora

Build with Fedora 25 Docker container so that I can use up-to-date software.
 
    mkdir -p /root/build/fedora25
    docker run -it --rm -h fedora25-build --name fedora25-build -v /root/build/fedora25:/usr/local -e "http_proxy=$http_proxy"  -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' -e 'LD_RUN_PATH=/usr/local/lib:/usr/local/lib64' fedora:25 /bin/bash
    docker run -it --rm -h fedora25-client --name fedora25-client -v /root/build/fedora25:/usr/local -e "http_proxy=$http_proxy"  -e "https_proxy=$http_proxy" -e "ftp_proxy=$http_proxy" -e 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' -e 'LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' -e 'LD_RUN_PATH=/usr/local/lib:/usr/local/lib64' fedora:25 /bin/bash