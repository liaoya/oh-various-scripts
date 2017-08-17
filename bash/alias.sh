if [ $(id -u) -eq 0 ]; then
    alias remove-old-kernel='rpm -e $(rpm -qa | grep -E "^kernel" | grep -v $(uname -r))'
else
    alias remove-old-kernel='sudo rpm -e $(rpm -qa | grep -E "^kernel" | grep -v $(uname -r))'
fi