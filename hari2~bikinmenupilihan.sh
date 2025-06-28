#!/bin/bash
echo "=== MENU PILIHAN ==="
echo "1. Cek nama"
echo "2. Ucapkan selamat"
echo "3. Keluar"

read -p "Pilih menu (1/2/3): " pilihan

if [ $pilihan -eq 1 ]; then
    read -p "Masukkan namamu: " nama
    echo "Halo, $nama! "

elif [ $pilihan -eq 2 ]; then
    echo "Salam kenal"
elif [ $pilihan -eq 3 ]; then
    echo "Sampai jumpa lagi"
else
    echo "Pilihan tidak dikenal"
fi
