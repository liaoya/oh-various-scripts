# Steal and improve pathmunge () in /etc/profile
addpath () {
    if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
        if [ -d "$1" ]; then
            if [ "$2" = "-a" ] ; then
                export PATH=$PATH:$1
            else
                export PATH=$1:$PATH
            fi
        fi
    fi
}

addvariable () {
    if [ -d $2 ]; then
        export "$1=$2"
    fi
}

addvariablepath() {
    addvariable $1 $2
    if [ -d "$2" ]; then
        if [ -d "$2"/bin ]; then
            addpath "$2/bin"
        else
            addpath "$2"
        fi
    fi
}
