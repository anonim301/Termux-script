#!/bin/bash

menu() {
    echo "============================"
    echo "      PROGRAM SERBAGUNA     "
    echo "============================"
    echo "1. Cek Kategori Umur"
    echo "2. Kalkulator Sederhana"
    echo "3. Keluar"
    echo "============================"
}

while true; do
    menu
    read -p "Pilih menu (1/2/3): " pilihan

    if [ $pilihan -eq 1 ]; then
        read -p "Masukkan nama kamu: " nama
        read -p "Masukkan umur kamu: " umur

        if [ $umur -lt 5 ]; then
            echo "$nama masih balita 👶"
        elif [ $umur -lt 13 ]; then
            echo "$nama masih anak-anak 🧒"
        elif [ $umur -lt 18 ]; then
            echo "$nama remaja 🧑"
        elif [ $umur -lt 60 ]; then
            echo "$nama sudah dewasa 🧔"
        else
            echo "$nama sudah lansia 👴"
        fi

    elif [ $pilihan -eq 2 ]; then
        read -p "Masukkan angka pertama: " angka1
        read -p "Masukkan operator (+ - * /): " operator
        read -p "Masukkan angka kedua: " angka2

        if [ "$operator" = "+" ]; then
            hasil=$(echo "$angka1 + $angka2" | bc)
        elif [ "$operator" = "-" ]; then
            hasil=$(echo "$angka1 - $angka2" | bc)
        elif [ "$operator" = "*" ]; then
            hasil=$(echo "$angka1 * $angka2" | bc)
        elif [ "$operator" = "/" ]; then
            hasil=$(echo "scale=4; $angka1 / $angka2" | bc)
        else
            echo "Operator tidak dikenali!"
            continue
        fi
        echo "Hasil: $hasil"

    elif [ $pilihan -eq 3 ]; then
        echo "Terima kasih, program selesai."
        break

    else
        echo "Pilihan tidak ada!"
    fi

    echo "----------------------------"
done

