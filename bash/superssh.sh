# https://stackoverflow.com/questions/16654607/using-getopts-inside-a-bash-function
# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash

checksshpass() {
    if [ test $(which sshpass) ]; then
        return 0
    else
        echo "Please install sshpass"
        return 1
    fi
}

superssh() {
    superssh_usage() { echo "superssh: [-h <server>] [-P <port>] [-u <user>] [-p <password>] [-d] [-a <login|copykey>]"; }

    local OPTIND server port=22 user="root" password debug=0 action="login"
    while getopts ":a:h:P:p:u:d" o; do
        case "${o}" in
            a)
                action="${OPTARG}"
                ;;
            h)
                server="${OPTARG}"
                ;;
            P):
                port="${OPTARG}"
                ;;
            p):
                password="${OPTARG}"
                ;;
            u):
                user="${OPTARG}"
                ;;
            d):
                debug=1
                return 0
                ;;
            *)
                superssh_usage
                return 0
                ;;
        esac
    done

    if [ $debug -gt 0 ]; then
        echo "The user $user with password \"$password\" to host $server on port $port, the action is $action"
        return 0
    fi

    if [[ checksshpass && -n server && -n password ]]; then
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

sshvagrant() {
    superssh -h $1 -u "vagrant" -p "vagrant"
}

sshadmusr() {
    superssh -h $1 -u "admusr" -p "Dukw1@m?"
}

sshNG() {
    superssh -h $1 -p "NextGen"
}

sshfib() {
    superssh -h $1 -p "fib%yel5"
}

sshcamiant() {
    superssh -h $1 -p "camiant"
}

sshpolicies() {
    superssh -h $1 -p "policies"
}
