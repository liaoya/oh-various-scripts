source $(dirname ${BASH_SOURCE[0]})/func.sh

[ -d /opt/go ] &&  addvariablepath "GOROOT" "/opt/go"
[ -d /opt/gopath ] &&  addvariablepath "GOPATH" "/opt/gopath"
[ -d /opt/sdkman ] && addvariable "SDKMAN_DIR" "/opt/sdkman" && source "$SDKMAN_DIR/bin/sdkman-init.sh"
[ -d /opt/jabba ] && addvariable "JABBA_HOME" "/opt/jabba" && source "$JABBA_HOME/jabba.sh"
