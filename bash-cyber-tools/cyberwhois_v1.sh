#!/bin/bash
# ========================================
# Script      : whois_lookup_v1.sh
# Deskripsi   : Mencari informasi Domain dengan whois
# Penggunaan  : ./whois_lookup_v1.sh
# Dibuat oleh : Yanuar
# Tanggal     : 24-07-2025
# ========================================

# Warna
GREEN="\e[32m"
RED="\e[31m"
CYAN="\e[36m"
NC="\e[0m"

# Banner pembuka
figlet -f slant "CyberWhois" | lolcat

# Buat folder hasil
mkdir -p whois_aktivitas

# Output file
hasil_output="whois_aktivitas/file_$(date +%Y-%m-%d_%H-%M-%S).txt"
log_file="whois_aktivitas/whois_aktivitas.log"

# Cek dan install whois
if ! command -v whois &> /dev/null
then
  echo -e "${RED}Whois belum terinstall"
  pkg install whois -y
  exit 1
fi

# Cek koneksi internet
ping -c 1 google.com &> /dev/null
if [[ $? -eq 0 ]]
then
  echo -e "${GREEN}[+] Koneksi ONLINE...."
else
  echo -e "${RED}[-] Koneksi OFFLINE..."
  exit 1
fi

# Spinner
dot_spinner() {
  local pid=$!
  while kill -0 $pid 2>/dev/null
  do
    for i in "." ".." "..." "...."
    do
      printf "\rLoading$i "
      sleep 0.3
    done
  done
  printf "\rDone!    \n"
}

# Input domain utama
echo -e "${CYAN}Masukkan domain yang ingin dicari (contoh: google.com)"
read -p "Masukkan domain: " target_domain
#input domain dalam file/multi domain
read -p "Masukkan nama file yang berisi daftar domain (kosongkan jika tidak ada): " target_file

# Validasi domain
if [[ -z $target_domain && -z $target_file ]]
then
  echo -e "${RED}[!] Domain tidak boleh kosong.... "
  exit 1
fi
if [[ -n $target_domain ]] 
then
	if ! [[ $target_domain =~ ^[a-zA-Z0-9.-]+$ ]]
	then
  echo -e "${RED}[!] Format domain tidak valid!${NC}"
  exit 1
	fi
fi

# Proses multi domain
if [[ -n $target_file && -f $target_file ]]
then
  while read domain
  do
	#skip baris kosong
	[[ -z $domain ]] && continue

	#validasi format sederhana
	if [[ ! $domain =~ ^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]
	then
		echo -e "${RED} Format domain tidak valid!: $domain"		continue
	fi

	echo -e "${CYAN}[!] Mencari informasi $domain"
    whois $domain >> $hasil_output
    echo -e "\n======================================\n" >> $hasil_output
  done < $target_file
else
  echo -e "${GREEN}[!] Mencari informasi Domain..."
  whois $target_domain >> $hasil_output
  dot_spinner
fi

# Ambil info penting
echo -e "${GREEN} Informasi penting:"
grep -Ei "Registrar: | Creation Date: | Expiry Date: | Name Server:" $hasil_output

# Simpan log aktivitas
if [[ -n $target_file && -f $target_file ]]
then
  echo -e "$(date '+%Y-%m-%d_%H-%M-%S') - Whois lookup for domains in file: $target_file" >> "$log_file"
  else
    echo -e "$(date '+%Y-%m-%d_%H-%M-%S') - Whois lookup for domain: $target_domain" >> "$log_file"
    fi

    cat "$hasil_output" >> "$log_file"
    echo -e "______SELESAI______\n" >> "$log_file"

# Tampilkan sebagian hasil
echo -e "${GREEN}[!] Hasil disimpan di $hasil_output"
echo -e "${GREEN}Beberapa baris pertama informasi domain..."
head -n 15 $hasil_output
