#!/bin/bash
echo "====SMART SCANNER===="
read -p "Masukkan target:" target

if ping -c 2 $target &> /dev/null; then
    echo "Target aktif! memulai scan... "
    nmap -p 22,80,433 $target
else
    echo "Target tidak merespon. Cek koneksi atau URL"
fi

