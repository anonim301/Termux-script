#!/bin/bash

GREEN="\e[32m"
RED="\e[31m"
NC="\e[0m"

logfile="hasil$(date +%Y-%m-%d_%H-%M-%S).txt"

#Cek apa nmap tersedia
if ! command -v nmap &> /dev/null; then
  echo -e "${RED}Nmap belum terinstal! Silakan instal dulu."
  exit 1
fi

#Input Target dan port
read -p "Masukkan ip/url target:" target
read -p "Port apa saja yg ingin anda scan (contoh:22,80,443):" port

#Validasi input
if [[ -z "$target" || -z "$port" ]];then
	echo -e "${RED}❌Target atau port tidak boleh kosong! ${NC}"
	exit 1
fi

#Cek apakah Target aktif
if ping -c 2 $target &> /dev/null; then
	echo -e "${GREEN}✅Target aktif! Mulai scan...${NC} "

#jalankan nmap dan simpann
	nmap -p "$port" "$target" -oN "$logfile"

	echo -e "${GREEN}Scan selesai!${NC} Hasil disimpan di file: $logfile"
	echo "📄 Isi log hasil scan:"
	cat "$logfile"

#Buka file log langsung
read -p "Ingin membuka hasil scan? (y/n):" jawab
if [[ "$jawab" == "y" ]]; then
	 less "$logfile"
fi

#Input jika target tidak aktif
else
        echo -e "${RED}❌Target tidak aktif! Cek koneksi atau IP/URL yang kamu masukkan!${NC}"
fi
