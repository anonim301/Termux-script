#!/bin/bash
# ========================================
# Script      : whois_lookup.sh
# Deskripsi   : Mencari informasi Domain dengan whois
# Penggunaan  : ./whois_lookup.sh
# Dibuat oleh : Yanuar
# Tanggal     : 24-07-2025
# ========================================

#warna 
GREEN="\e[32m"
RED="\e[31m"
CYAN="\e[36m"

#Banner pembuka(figlet+lolcat)
figlet -f slant "CyberWhois" | lolcat

#output file 
hasil_output="file_$targets_file_$(date +%Y-%m-%d_%H-%M-%S).txt"

#Cek dan install whois
if ! command -v nmap &> /dev/null
then
  echo -e "${RED}Whois belum terinstall"
  pkg install whois -y
  exit 1 #keluar program dan mulai lagi
fi

#Spinner (Animasi loading)
dot_spinner() {
  local pid=$!
  while kill -0 $pid 2>/dev/null; do
    for i in "." ".." "..." "...."; do
      printf "\rLoading$i "
      sleep 0.3
    done
  done
  printf "\rDone!    \n"
}

#input target/domain
  echo -e "${CYAN}Masukkan domain yang ingin dicari(contoh: google.com)"
  read -p "Masukkan domain yang ingin dicari:" targets_domain
#jalankan whois
  echo -e "{GREEN}[!] Mencari informasi Domain..."
  whois $targets_domain > $hasil_output & dot_spinner

#Tampilkan sebagian hasil 
echo -e "${GREEN}[!] Hasil disimipan di $hasil_output"
echo -e "${GREEN}Beberapa baris pertama informasi domain..."
head -n 15 $hasil_output


