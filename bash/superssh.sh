# https://stackoverflow.com/questions/16654607/using-getopts-inside-a-bash-function
# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash

superssh() {
    superssh_usage() { echo "superssh: [-s <server>] [-p <port>] [-u <user>] [-P <password>] [-d] [-o <login|copykey>]"; }

    local OPTIND server="localhost" port=22 user="root" password debug=0 action="login" noop=0
    while getopts "o:s:p:P:u:d" o; do
        case "${o}" in
            o)
                action="${OPTARG}"
                ;;
            s)
                server="${OPTARG}"
                ;;
            p):
                port="${OPTARG}"
                ;;
            P):
                password="${OPTARG}"
                ;;
            u):
                user="${OPTARG}"
                ;;
            d):
                debug=1
                noop=1
                ;;
            *)
                superssh_usage
                noop=1
                ;;
        esac
    done

    if [ $debug -gt 0 ]; then
        echo "The user $user with password \"$password\" to host $server on port $port, the action is $action"
        noop=1
    fi

    if [[ ! $(command -v sshpass) ]]; then
        noop=1
        echo "Please install sshpass at first"
    fi

    if [[ $noop -eq 0 && -n server && -n password ]]; then
        if [[ $action == "login" ]]; then
                sshpass -p "${password}" ssh -o UserKnownHostsFile=/dev/null -o ServerAliveInterval=60 -o StrictHostKeyChecking=no -p $port $user@$server
        elif [[ $action == "copykey" ]]; then
            if [[ -f ~/.ssh/id_rsa.pub ]]; then
                sshpass -p "${password}" ssh-copy-id -o UserKnownHostsFile=/dev/null -o ServerAliveInterval=60 -o StrictHostKeyChecking=no -p $port $user@$server
            else
                echo "Please generate ssh key at first"
            fi
        fi
    fi
}

alias sshvagrant='superssh -u "vagrant" -P "vagrant" "$@"'
alias sshadmusr='superssh -u "admusr" -P "Dukw1@m?" "$@"'
alias sshNG='superssh -P "NextGen" $@'
alias sshfib='superssh -P "fib%yel5" "$@"'
alias sshcamiant='superssh -P "camiant" "$@"'
alias sshpolicies='superssh -P "policies" "$@"'
alias super-ssh-copy-id='superssh -o copykey "$@"'