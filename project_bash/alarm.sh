#!/bin/bash

echo "⏰ Alarm Bash Sederhana"
read -p "Masukkan waktu (dalam menit): " menit

if ! [[ "$menit" =~ ^[0-9]+$ ]]; then
  echo "Input tidak valid. Harus berupa angka."
  exit 1
fi

detik=$((menit * 60))
echo "Alarm disetel selama $menit menit. Mulai hitung mundur..."

while [ $detik -gt 0 ]; do
  menit_sisa=$((detik / 60))
  detik_sisa=$((detik % 60))
  printf "\rSisa waktu: %02d:%02d" $menit_sisa $detik_sisa
  sleep 1
  ((detik--))
done

echo -e "\n⏰ Waktu habis! Alarm berbunyi!"

# Jika pakai Termux:
termux-toast "⏰ ALARM: Waktu Habis!"
termux-vibrate -d 500
termux-notification --title "Alarm" --content "Waktu habis!" --sound

exit 1
