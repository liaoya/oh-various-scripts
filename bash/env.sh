source $(dirname ${BASH_SOURCE[0]})/func.sh

# Go Configuration
[ -d /opt/go ] &&  addvariablepath "GOROOT" "/opt/go"
[ -d /opt/gox ] && [ -d /opt/gopath ] &&  addvariable "GOPATH" "/opt/gox:/opt/gopath"
[ -d /opt/gox/bin ] && addpath "/opt/gox/bin" "-a"
[ -d /opt/gopath/bin ] && addpath "/opt/gopath/bin" "-a"

# JDK Configuration
[ -d /opt/sdkman ] && addvariable "SDKMAN_DIR" "/opt/sdkman" && source "$SDKMAN_DIR/bin/sdkman-init.sh"
[ -d /opt/jabba ] && addvariable "JABBA_HOME" "/opt/jabba" && source "$JABBA_HOME/jabba.sh"
addvariable "JAVALIB" "/opt/javalib"
[ -x $JAVALIB/idea-IC/bin/idea.sh ] && alias classfind="java -jar $JAVALIB/classfinder.jar"
[ -f $JAVALIB/jd-gui.jar ] && alias jdgui="nohup java -jar $JAVALIB/jd-gui.jar 1>/dev/null 2>&1"

# Packer Configuration
export PACKER_KEY_INTERVAL=10ms
export PACKER_CACHE=~/.cache/packer

unset -f addpath addvariable addvariablepath