#!/bin/bash

angka_rahasia=$((RANDOM % 100 + 1))
jumlah_tebakan=0
batas_tebakan=7
skor=100

echo "=================================="
echo "     🎲 Game Tebak Angka 🎲"
echo " Tebak angka dari 1 sampai 100"
echo " Max percobaan: $batas_tebakan"
echo "=================================="

while (( jumlah_tebakan < batas_tebakan )); do
    read -p "Tebakanmu: " tebakan

    if ! [[ "$tebakan" =~ ^[0-9]+$ ]]; then
        echo "⛔ Masukkan hanya angka!"
        continue
    fi

    ((jumlah_tebakan++))
    ((skor-=10))

    if (( tebakan < angka_rahasia )); then
        echo "🔻 Terlalu kecil!"
    elif (( tebakan > angka_rahasia )); then
        echo "🔺 Terlalu besar!"
    else
        skor=$((skor + 10))  # bonus poin karena benar
        echo "🎉 Benar! Angkanya: $angka_rahasia"
        echo "🧮 Jumlah tebakan: $jumlah_tebakan"
        echo "🏆 Skor akhir: $skor"
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Benar dalam $jumlah_tebakanx tebakan | Skor: $skor" >> hasil_skor.txt
        exit
    fi
done

echo "😢 Kamu gagal menebak dalam $batas_tebakan percobaan!"
echo "📉 Angka rahasia adalah: $angka_rahasia"
echo "🏆 Skor akhir: 0"
echo "$(date '+%Y-%m-%d %H:%M:%S') - Gagal menebak | Skor: 0" >> hasil_skor.txt
