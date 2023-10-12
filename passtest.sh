#!/bin/bash

password=$1
len="${#password}"

if test $len -ge 8 ; then
    echo "$password" | grep -q [0-9]
    if test "$?" -eq 0; then
        echo "$password" | grep -q [@#\$%\&*-+=]
        if test "$?" -eq 0; then
            echo "Strong password"
        else
            echo "Password must include special characters @, #, $, %, &, -, + or ="
        fi
    else
        echo "Password must include numbers"
    fi
else
    echo "Password length must be at least 8 characters"
fi