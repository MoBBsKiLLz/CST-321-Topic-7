#!/bin/bash

file=$1
group=$2

if test $# -gt 0; then
    case "$3" in
        -a) 
            echo "add  user"
            while read username password; do
                echo "Username: $username Password: $password"
            done <$file
            ;;
        -r) 
            echo "remove user"
            ;;
    esac
fi