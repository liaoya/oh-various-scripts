#!/bin/bash

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

if [[ -n ${FISH_VERSION} && -n ${FISH_URL} && -n ${FISH_SRCDIR} ]]; then
    prepare_build "fish"

    if [ -d $HOME/${FISH_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${FISH_SRCDIR}
        ./configure -q --build=x86_64-pc-linux --host=x86_64-pc-linux --target=x86_64-pc-linux
        make -s -j $(nproc) all
        make -s install
        for item in $(ls -1 /usr/local/bin/fish*); do file $item | grep -q -s "not stripped" && strip $item; done
        cat <<'EOF' >> /usr/local/bin/install-fish.sh
if [ $UID -eq 0 ]; then
    grep -s -q "/usr/local/bin/fish" /etc/shells || echo /usr/local/bin/fish | tee -a /etc/shells
    [[ $(command -v sestatus) ]] && sestatus | grep "SELinux status" | grep -s -q "enabled" && chcon -t shell_exec_t /usr/local/bin/fish
    [ -f /etc/redhat-release ] && yum install -y -q pcre2-utf32 pcre2-utf16 pcre2
fi
mkdir -p $HOME/.config/fish
[ -f $HOME/.config/fish/config.fish ] || touch ~/.config/fish/config.fish
grep -s -q -w 'set PATH \$PATH /usr/sbin' $HOME/.config/fish/config.fish || echo 'set PATH $PATH /usr/sbin' >> ~/.config/fish/config.fish
grep -s -q -w 'set PATH \$PATH /usr/local/sbin' $HOME/.config/fish/config.fish || echo 'set PATH $PATH /usr/local/sbin' >> ~/.config/fish/config.fish
EOF
        chmod a+x /usr/local/bin/install-fish.sh

        compress_binary fish-${FISH_VERSION} /usr/local/bin/fish
    else
        echo "Fail to download fish"
    fi
else
    echo "Don't define variable fish"
fi
