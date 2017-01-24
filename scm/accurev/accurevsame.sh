#!/bin/sh

usage="Usage: -v (child stream) -V (parent stream)"
parent=""
child=""

while getopts "v:V:h" arg
do
    case $arg in
        v):
            child=$OPTARG
            ;;
        V):
            parent=$OPTARG
            ;;
        h):
            echo $usage
            exit 0
            ;;
    esac
done

if [ -z "$parent" ] || [ -z "$child" ]; then
    echo $usage
    exit 1
fi


for file in $(accurev stat -d -s $child | grep -v "(defunct)" | awk '{print $1}'); do
    accurev diff -B -w -v $parent -V $child $file 1>/dev/null 2>&1
    if [ $? -eq 0 ]; then
		echo ${file}
    fi
done
