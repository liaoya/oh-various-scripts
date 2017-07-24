[ -x /usr/bin/dnf ] && alias dnflocal='sudo dnf --disablerepo=\* --enablerepo=\*-local'
[ -x /usr/bin/yum ] && alias yumlocal='sudo yum --disablerepo=\* --enablerepo=\*-local'