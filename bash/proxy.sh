# https://stackoverflow.com/questions/263005/is-it-possible-to-change-the-environment-of-a-parent-process-in-python
# https://stackoverflow.com/questions/35780715/setting-environment-variables-of-parent-shell-in-python
# https://stackoverflow.com/questions/716011/why-cant-environmental-variables-set-in-python-persist

setup_proxy() {
  export http_proxy=http://$1:$2
  export HTTP_PROXY=http://$1:$2
  export https_proxy=$http_proxy
  export HTTPS_PROXY=$http_proxy
  export ftp_proxy=$http_proxy
  export FTP_PROXY=$http_proxy
  export rsync_proxy=$1:$2
  export RSYNC_PROXY=$1:$2
  export no_proxy="localhost,127.0.0.1,cn.oracle.com,jp.oracle.com,us.oracle.com,.oraclecorp.com,$3"
  export NO_PROXY="localhost,127.0.0.1,cn.oracle.com,jp.oracle.com,us.oracle.com,.oraclecorp.com,$3"

  export JAVA_OPTS="-Dhttp.proxyHost=$1 -Dhttp.proxyPort=$2 -Dhttps.proxyHost=$1 -Dhttps.proxyPort=$2"
}

setup_proxy_cn() {
  setup_proxy cn-proxy.jp.oracle.com 80 "10.113.69.79,10.113.69.101"
  echo -e "Set Proxy for China"
}

setup_proxy_jp() {
  setup_proxy jp-proxy.jp.oracle.com 80 ""
  echo -e "Set Proxy for Japan"
}

setup_proxy_us() {
  setup_proxy www-proxy.us.oracle.com 80 "localhost,127.0.0.1,cn.oracle.com,jp.oracle.com,us.oracle.com,.oraclecorp.com"
  echo -e "Set Proxy for USA"
}

setup_proxy_office() {
  setup_proxy 10.182.172.49 3128 "10.113.69.79,10.113.69.101"
  echo -e "Set Proxy for Office"
}

setup_proxy_lab() {
  setup_proxy 10.113.69.101 3128 "10.113.69.79,10.113.69.101"
  echo -e "Set Proxy for Lab"
}

proxy_off(){
  unset http_proxy HTTP_PROXY https_proxy HTTPS_PROXY ftp_proxy FTP_PROXY RSYNC_PROXY RSYNC_PROXY no_proxy NO_PROXY
  echo -e "Proxy environment variable removed."
}
