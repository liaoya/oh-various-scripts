source $(dirname ${BASH_SOURCE[0]})/func.sh

addpath "/usr/sbin"
addpath "/usr/local/bin"
addvariablepath "ACCUREV_BINARY" "/public/accurev" -a

addpath "/opt/node/bin"

# Go Configuration
[[ -d /opt/gox && -d /opt/gopath ]] && export GOPATH="/opt/gox:/opt/gopath"
addvariablepath "GOROOT" "/opt/go"
addpath "/opt/gopath/bin"
addpath "/opt/gox/bin"

# JDK Configuration
[ -d /opt/sdkman ] && addvariable "SDKMAN_DIR" "/opt/sdkman" && source "$SDKMAN_DIR/bin/sdkman-init.sh"
[ -d /opt/jabba ] && addvariable "JABBA_HOME" "/opt/jabba" && source "$JABBA_HOME/jabba.sh"
addvariable "JAVALIB" "/opt/javalib"
[ -x $JAVALIB/classfinder.jar ] && alias classfind="java -jar $JAVALIB/classfinder.jar"
[ -f $JAVALIB/jd-gui.jar ] && alias jdgui="nohup java -jar $JAVALIB/jd-gui.jar 1>/dev/null 2>&1"

# Packer Configuration
export PACKER_KEY_INTERVAL=10ms
export PACKER_CACHE=~/.cache/packer

# OCPM build environments
export ACCUREV_WORKSPACE_BASE=/work/accurevws
export ACCUREV_USER=tom.shen
export ACCUREV_PASSWORD=tshen
export WORK_DIR_BASE=/work/build
export SHARED_REPO_URL=http://10.182.172.49
export IS_BUILD_SERVER=1
export OCPM_BUILD_VERBOSE=1

unset -f addpath addvariable addvariablepath