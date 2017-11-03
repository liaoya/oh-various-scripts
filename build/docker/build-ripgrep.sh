#!/bin/sh

if [ -f ../env.sh ]; then
    source ../env.sh
else
    echo "Can't import common functions and variables"
    exit 1
fi

# https://github.com/BurntSushi/ripgrep

if [[ -n ${RIPGREP_VERSION} && -n ${RIPGREP_URL} && -n ${RIPGREP_SRCDIR} ]]; then
    prepare_build "RIPGREP"

    if [ -d $HOME/${RIPGREP_SRCDIR} ]; then
        clear_usrlocal
        cd $HOME/${RIPGREP_SRCDIR}
        cargo build --release
        if [ -x target/release/rg ]; then
            strip target/release/rg
            [ -d /usr/local/bin ] || mkdir -p /usr/local/bin
            cp target/release/rg /usr/local/bin
            mkdir -p /usr/local/share/ripgrep
            for name in "rg.bash-completion" "rg.fish" "_rg"; do find . -name $name -exec cp -pr "{}" /usr/local/share/ripgrep \; ; done
            cat <<EOF > /usr/local/bin/install-rg.sh
#!/bin/bash
RG_SHARE=/usr/local/share/ripgrep
[[ $UID -eq 0 && -f $RG_SHARE/rg.bash-completion  && -d /etc/bash_completion.d ]] && cp -pr $RG_SHARE/rg.bash-completion /etc/bash_completion.d
[[ -n $XDG_CONFIG_HOME ]] || export XDG_CONFIG_HOME=$HOME/.config
[[ ! -f /etc/bash_completion.d/rg.bash-completion ]] && { mkdir -p $XDG_CONFIG_HOME/bash_completion; cp -pr $RG_SHARE/rg.bash-completion $XDG_CONFIG_HOME/bash_completion; }
[[ -d $HOME/.config/fish/completions ]] || mkdir -p $HOME/.config/fish/completions
[[ -f $HOME/.config/fish/completions/rg.fish ]] || cp -pr $RG_SHARE/rg.fish $HOME/.config/fish/completions/
[[ -n $fpath && ! -f $fpath/_rg ]] && cp -pr $RG_SHARE/_rg $fpath/
EOF
            chmod a+x /usr/local/bin/install-rg.sh

            compress_binary ripgrep-${RIPGREP_VERSION} /usr/local/bin/rg
        fi

    else
        echo "Fail to download ripgrep"
    fi
else
    echo "Don't define variable ripgrep"
fi
