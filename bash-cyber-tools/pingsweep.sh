#!/bin/bash

# ping sweep dengan dukungan hostname & subnet

input=$1

# cek apakah input adalah domain
if [[ "$input" =~ [a-zA-Z] ]]; then
    echo "Resolving domain: $input"
    ip_base=$(ping -c 1 "$input" | awk -F'[()]' '/PING/{print $2}')
else
    ip_base=$input
fi

echo "IP base isi: $ip_base"
