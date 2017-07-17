setup_proxy() {
  export http_proxy=http://$1:$2
  export HTTP_PROXY=http://$1:$2
  export https_proxy=$http_proxy
  export HTTPS_PROXY=$http_proxy
  export ftp_proxy=$http_proxy
  export FTP_PROXY=$http_proxy
  export rsync_proxy=$1:$2
  export RSYNC_PROXY=$1:$2
  export no_proxy="$3"
  export NO_PROXY="$3"
}

setup_proxy_cn() {
  setup_proxy cn-proxy.jp.oracle.com 80 "localhost,127.0.0.1,cn.oracle.com,jp.oracle.com,us.oracle.com,.oraclecorp.com"
  echo -e "Set Proxy for China"
}

setup_proxy_jp() {
  setup_proxy jp-proxy.jp.oracle.com 80 "localhost,127.0.0.1,cn.oracle.com,jp.oracle.com,us.oracle.com,.oraclecorp.com"
  echo -e "Set Proxy for Japan"
}

setup_proxy_us() {
  setup_proxy www-proxy.us.oracle.com 80 "localhost,127.0.0.1,cn.oracle.com,jp.oracle.com,us.oracle.com,.oraclecorp.com"
  echo -e "Set Proxy for USA"
}

proxy_off(){
    unset http_proxy HTTP_PROXY https_proxy HTTPS_PROXY ftp_proxy FTP_PROXY RSYNC_PROXY RSYNC_PROXY no_proxy NO_PROXY
    echo -e "Proxy environment variable removed."
}
