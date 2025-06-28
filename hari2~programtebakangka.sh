#! /bin/bash
read -p "Masukkan angka: " angka

if [ $angka -gt 15 ] ; then
    echo "Angkanya lebih besar dari 15"
else
    echo "Angkanya lebih kecil dari 15"
fi
