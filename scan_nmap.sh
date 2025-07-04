#!/bin/bash
read -p "Masukkan ip/domain target:" ip

if ping -c 1 $ip &> /dev/null; then
    echo "Target hidup! mulai scan... "
    nmap -p 80,443 $ip
else
    echo "Target mati, tidak bisa discan! "
fi

