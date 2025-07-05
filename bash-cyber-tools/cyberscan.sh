#!/bin/bash

logfile="hasil.txt"

#Cek apa nmap tersedia
if ! command -v nmap &> /dev/null; then
  echo "Nmap belum terinstal! Silakan instal dulu."
  exit 1
fi

#Input Target dan port
read -p "Masukkan ip/url target:" target
read -p "Port apa saja yg ingin anda scan:" port

#Cek apkag Target aktif
if ping -c 2 $target &> /dev/null; then
    echo "Target aktif! Mulai scan... "

#jalankan nmap dan simpan
    nmap -p "$port" "$target" -oN "$logfile"

    echo "✅Scan selesai! Hasil disimpaj di file: $logfile"
    echo "📄 Isi log hasil scan:"
    cat "$logfile"
else
    echo "❌ Target tidak aktif! Cek koneksi atau IP/URL yang kamu masukkan!"
fi

