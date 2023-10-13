#!/bin/bash

file=$1
group=$2

if test $# -gt 0; then
    case "$3" in
        -a) 
            if [ $(getent group $group) ]; then
                while read username password; do
                    egrep "^$username" /etc/passwd >/dev/null
                    if [ $? -eq 0 ]; then
                        echo "$username exists!"
                    else
                        useradd -m -p "$password" "$username"
                        usermod -a -G "$group" "$username"
                        [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
                    fi
                done <$file
            else
                while read username password; do
                    egrep "^$username" /etc/passwd >/dev/null
                    if [ $? -eq 0 ]; then
                        echo "$username exists!"
                    else
                        groupadd "$group"
                        useradd -m -p "$password" "$username"
                        usermod -a -G "$group" "$username"
                        [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
                    fi
                done <$file
            fi
            ;;
        -r) 
            while read username password; do
                userdel "$username"
                userdel -r "$username"
                [ $? -eq 0 ] && echo "User has been removed from the system!" || echo "Failed to remove a user!"
            done <$file
            ;;
    esac
fi