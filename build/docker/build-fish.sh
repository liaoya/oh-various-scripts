#!/bin/bash

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n ${FISH_VERSION} && -n ${FISH_URL} && -n ${FISH_SRCDIR} ]]; then
    prepare_build "FISH"

    if [ -d ~/${FISH_SRCDIR} ]; then
        clear_usrlocal
        cd ~/${FISH_SRCDIR}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) all
        make -s install
        for item in $(ls -1 /usr/local/bin/fish*); do file $item | grep -q -s "not stripped" && strip $item; done
        cat <<'EOF' >> /usr/local/bin/installfish.sh
if [ $UID -eq 0 ]; then
    grep -s -w "/usr/local/bin/fish" /etc/shells || echo /usr/local/bin/fish | tee -a /etc/shells
    sestatus | grep "SELinux status" | grep -s -q "enabled" && chcon -t shell_exec_t /usr/local/bin/fish
    [ -f /etc/redhat-release ] && yum install -y -q pcre2-utf32 pcre2-utf16 pcre2
fi
mkdir -p ~/.config/fish
[ -f ~/.config/fish/config.fish ] || touch ~/.config/fish/config.fish
grep -s -q -w 'set PATH \$PATH /usr/sbin' ~/.config/fish/config.fish || echo 'set PATH $PATH /usr/sbin' >> ~/.config/fish/config.fish
grep -s -q -w 'set PATH \$PATH /usr/local/sbin' ~/.config/fish/config.fish || echo 'set PATH $PATH /usr/local/sbin' >> ~/.config/fish/config.fish
EOF
        chmod a+x /usr/local/bin/installfish.sh

        compress_binary zsh-${FISH_VERSION}.txz
    else
        echo "Fail to download zsh"
    fi
else
    echo "Don't define variable zsh"
fi
