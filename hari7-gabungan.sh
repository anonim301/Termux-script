#!/bin/bash
while true; do
    echo "===Program Cek Umur==="
    read -p "Masukkan nama:" nama
    read -p "Masukkan umur:" umur

if [ $umur -lt 6 ]; then
    echo "$nama masih balita👶"
elif [ $umur -lt 13 ]; then
    echo "$nama masih anak-anak🧒"
elif [ $umur -lt 20 ]; then
    echo "$nxama masih remaja👧"
elif [ $umur -lt 60 ]; then
    echo "$nama sudah dewasa👨👩"
else 
    echo "$nama sudah lansia👴👵"
fi

echo "================="
read -p "Coba lagi? (Y/N):" lagi
if [ $lagi != "y" ]; then
    echo "Program selesai,Danke schön!!"
    break
fi
done

