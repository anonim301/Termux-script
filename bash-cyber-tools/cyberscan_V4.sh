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
    while ps -p $pid > /dev/null; do
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

#buat folder logs jika belum ada
mkdir -p logs

#cek nmap terinstall
if ! command -v nmap &> /dev/null
then
  echo -e "${RED}Nmap belum terinstal! Silakan instal dulu: pkg install nmap${NC}"
  exit 1
fi

#Scan banyak target
read -p "Scan banyak target dari file? (y/n): " multi
if [[ "$multi" == "y" ]]; then
    read -p "Masukkan path file daftar target (1 target per baris): " file
    if [ ! -e "$file" ]; then
        echo -e "${RED}❌ File tidak ditemukan!${NC}"
        exit 1
    fi

    # Pilih mode scan
    echo -e "${CYAN}Pilih jumlah scan untuk semua target:"
    echo "[1] Scan port tertentu (custom)"
    echo "[2] Scan port umum (1-1000)"
    echo "[3] Full scan (1-65535)"
    read -p "> Pilih [1/2/3]: " mode

    case $mode in
        1)
          read -p "🛠Port apa saja yang ingin anda scan (contoh:22,80,443): " port_input
          if [[ -z $port_input ]]; then
                echo -e "${RED}❌Port tidak boleh kosong!${NC}"
                exit 1
          fi
          nmap_opts="-p $port_input -sV -T4"
          ;;
        2)
          nmap_opts="-p 1-1000 -sV -T4"
          ;;
        3)
          nmap_opts="-p- -sV -T4"
          ;;
        *)
          echo -e "${RED}❌Pilihan tidak valid!${NC}"
          exit 1
          ;;
    esac

    read -p "➕Tambahkan scan lanjutan (script scan & OS detection)? (y/n): " lanjut
    [[ "$lanjut" == "y" ]] && nmap_opts="$nmap_opts -sC"

    # Loop baca tiap target di file
    while IFS= read -r target; do
        [[ -z "$target" ]] && continue
        echo -e "${YELLOW}🚀 Scan target: $target${NC}"
        logfile="logs/hasil_${target//[^a-zA-Z0-9]/_}_$(date +%Y-%m-%d_%H-%M-%S).txt"
        (nmap $nmap_opts "$target" -oN "$logfile") &
        pid=$!
        spinner $pid
        if [[ -f "$logfile" ]]; then
            echo -e "${GREEN}✔️ Scan selesai untuk $target. File log: $logfile${NC}"
            echo -e "${CYAN}🔍 Port terbuka:"
            grep -i open "$logfile" | awk '{print "\033[32m"$0"\033[0m"}'
        else
            echo -e "${RED}❌ Gagal scan $target${NC}"
        fi
        echo ""
    done < "$file"
    exit 0
fi

# Input target single
read -p "Masukkan ip/url target: " target
if [[ "$target" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ || "$target" =~ ^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "✅ Format target valid: $target"
    host="$target"
else
    echo "❌ Format target tidak valid!"
    exit 1
fi

# Pilih mode scan single target
echo -e "${CYAN}Pilih jumlah scan:"
echo "[1] Scan port tertentu (custom)"
echo "[2] Scan port umum (1-1000)"
echo "[3] Full scan (1-65535)"
read -p "> Pilih [1/2/3]: " mode

case $mode in
    1)
      read -p "🛠Port apa saja yang ingin anda scan (contoh:22,80,443): " port_input
      if [[ -z $port_input ]]; then
            echo -e "${RED}❌Port tidak boleh kosong!${NC}"
            exit 1
      fi
      nmap_cmd="nmap -p $port_input $host -sV -T4"
      ;;
    2)
      nmap_cmd="nmap -p 1-1000 $host -sV -T4"
      ;;
    3)
      nmap_cmd="nmap -p- $host -sV -T4"
      ;;
    *)
      echo -e "${RED}❌Pilihan tidak valid!${NC}"
      exit 1
      ;;
esac

read -p "➕Tambahkan scan lanjutan (script scan & OS detection)? (y/n): " lanjut
[[ "$lanjut" == "y" ]] && nmap_cmd="$nmap_cmd -sC"

# Cek konektivitas
echo -e "${YELLOW}⚙️Mengecek konektivitas ke target...${NC}"
if ping -c 2 "$target" &> /dev/null; then
    echo -e "${GREEN}✅Target aktif! Mulai scan...${NC}"
else
    echo -e "${RED}❓Ping gagal. Lanjutkan scan? (y/n):${NC}"
    read -p "> " lanjut_ping
    if [[ "$lanjut_ping" != "y" ]]; then
        echo -e "${RED}❌Scan dibatalkan.${NC}"
        exit 1
    else
        echo -e "${YELLOW}Melanjutkan scan meskipun ping gagal...${NC}"
    fi
fi

# Jalankan scan single target
logfile="logs/hasil_$(date +%Y-%m-%d_%H-%M-%S).txt"
echo -e "${CYAN}🚀Menjalankan scan...${NC}"
($nmap_cmd -oN "$logfile") &
pid=$!
spinner $pid

# Tampilkan hasil scan
if [[ -f "$logfile" ]]; then
    echo -e "${GREEN}Scan selesai!${NC}"
    echo -e "${GREEN} Hasil disimpan di file: $logfile"
    echo -e "${GREEN}📄 Port yang terbuka:"
    grep -i open "$logfile" | awk '{print "\033[32m"$0"\033[0m"}'

    read -p "Lihat hasil lengkap? (y/n): " jawab
    if [[ "$jawab" == "y" ]]; then
        less "$logfile"
    fi
else
    echo -e "${RED}❌Target tidak aktif atau scan gagal!${NC}"
fi
