#!/bin/bash

#warna
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
CYAN="\e[36m"
NC="\e[0m"

#Spinner loading
spinner() {
	local pid=$! 
	local delay=0.2
	local spinstr='|/-\'
	while [  "$(ps a | awk '{print $1}' | grep $pid)" ]; do
	local temp=${spinstr#?}
	printf " [%c] " "$spinstr"
	spinstr=$temp${spinstr%"$temp"}
	sleep $delay
	printf "\b\b\b\b\b\b"
  done
  printf "  \b\b\b\b"
}

#Banner
clear
echo -e "${CYAN}"
figlet -f slant "Port Scanner" | lolcat
echo -e "${NC}"

#file log
mkdir -p logs
logfile="logs/hasil_$(date +%Y-%m-%d_%H-%M-%S).txt"

#Cek apa nmap tersedia
if ! command -v nmap &> /dev/null; then
  echo -e "${RED}Nmap belum terinstal! Silakan instal dulu: $(pkg install nmap)${NC}"
  exit 1
fi

#Input Target 
read -p "Masukkan ip/url target:" target
if [[ -z "$target" ]]; then
	echo -e "${RED}❌Target tidak boleh kosong! ${NC}"
	exit 1
fi
if ! [[ "$target" =~ ^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
  echo -e "${RED}❌ Format target tidak valid!${NC}"
  exit 1
fi

#Pilih mode scan
echo -e "${CYAN}Pilih jumlah scan:"
echo "[1] Scan port tertentu (custom)" 
echo "[2] Scan port umum (1-1000)"
echo "[3] Full scan (1-65535)"
read -p "> Pilih [1/2/3]:" mode

case $mode in
	1)
	  read -p "🛠Port apa saja yang ingin anda scan(contoh:22,80,443):" port
	  if [[ -z "$port" ]]; then 
		echo -e "${RED}❌Port tidak boleh kosong! ${NC}" 
		exit 1
	  fi
	  nmap_cmd="nmap -p $port $target -sV -T4"
	  ;;
	2) 
	  nmap_cmd="nmap -p 1-1000 $target -sV -T4"
	  ;;
	3) 
	  nmap_cmd="nmap -p- $target -sV -T4"
	  ;;
	*) 
	  echo -e "${RED}❌Pilihan tidak valid! ${NC}"
	  exit 1
	  ;;
esac

#Tambahkan opsi -sC -O
read -p "➕Tambahkan scan lanjutan (default script scan & OS detection)? (y/n):" lanjut
[[ "$lanjut" == "y" ]] && nmap_cmd="$nmap_cmd -sC"

#Cek konektivitas target
echo -e "${YELLOW}⚙️Mengecek konektivitas ke target...${NC}"
if ping -c 2 $target &> /dev/null; then
	echo -e "${GREEN}✅Target aktif! Mulai scan...${NC} "
else
	echo -e "${RED}❓Ping gagal. Lanjutkan scan? (y/n):${NC}"
	read -p ">" lanjut_ping
	if [[ "$lanjut_ping" != "y" ]]; then
  		echo -e "${RED}❌ Format target tidak valid!${NC}"
  		exit 1
	else
		echo -e "${YELLOW}Melanjutkan meskipun ping gagal...${NC}"
	fi
fi

#Jalankan nmap/scan
echo -e "${CYAN}🚀Menjalankan scan...${NC}"
($nmap_cmd -oN "$logfile")
pid=$! 
spinner $pid

#Simpann log
if [[ -f "$logfile" ]]; then
	echo -e "${GREEN}Scan selesai!${NC}"
	echo -e "${GREEN} Hasil disimpan di file: $logfile"
	echo -e "${GREEN}📄 Port yg terbuka:"

	echo -e "${CYAN}🔍Port yang terbuka...${NC}"
	grep -i open "$logfile" | awk '{print "\033[32m"$0"\033[0m"}'

#Buka file log langsung
	read -p "Lihat hasil lengkap? (y/n):" jawab
	if [[ "$jawab" == "y" ]]; then
	 less "$logfile"
	fi

#Input jika target tidak aktif
else
        echo -e "${RED}❌Target tidak aktif! Cek koneksi atau IP/URL yang kamu masukkan!${NC}"
fi
