#!/bin/bash
# ========================================
# Script      : cyberscan_V5.sh
# Deskripsi   : Port scanner dengan multi target
# Penggunaan  : ./cyberscan_V5.sh
# Dibuat oleh : Yanuar
# Tanggal     : 20-07-2025
# ========================================

#warna
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
CYAN="\e[36m"
NC="\e[0m"
BLUE="\e[34m"

#Banner
clear
echo -e "${CYAN}"
figlet -f slant "Port Scanner" | lolcat
echo -e "${NC}"
mkdir -p logs #buat folder logs jika belum ada


#Cek nmap terinstall
if ! command -v nmap &> /dev/null
then
        echo -e "${RED}Nmap belum terinstall! Silahkan install dulu!..."
        pkg install nmap
        exit
fi

#help
show_help() {
    echo -e "${BLUE} Usage: ${NC} $0"
        echo -e "${BLUE}Pilih target melalui file: (contoh: targets.txt) "
        exit 1
}

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

#scan mutli target
scan_multi() {
read -p "Gunakan multi target? (y/n): " multi_target
  if [[ $multi_target -eq "y" ]]
  then
      read -p "Masukkan path file daftar target (1 target per baris):" target_file
      if [[ ! -f $target_file ]]
      then
        echo -e "${RED}File tidak ditemukan"
        exit 1
      fi

        echo "====Pilih jenis Pemindaian===="
        echo "1.Fast scan"
        echo "2.Full scan"
        echo "3.Custom scan (-sC -sV -O)"
        read -p "Opsi pilih (1/2/3):" scan_option

        case $scan_option in
          1)
                nmap_cmd="-T4 -F"
                ;;
          2)
                nmap_cmd="-T4 -p-"
                ;;
          3)
                nmap_cmd="-sC -sV -O"
                ;;
          *)
                echo -e "${RED}Program tidak valid!!"
                exit 1
                ;;
        esac

        mkdir -p logs

        echo -e "${GREEN}Memulai scan multi-target...."
        cat $target_file | xargs -P 5 -I{} sh -c "nmap $nmap_cmd {} -oN logs/hasil_{}.txt"
        echo -e "${CYAN}Selesai scan hasil disimpan di folder logs "
        exit 0
  fi
}

 # Loop baca tiap target di file
    while IFS= read -r target; do
        [[ -z "$target" ]] && continue
        echo -e "${YELLOW}🚀 Scan target: $target${NC}"
        logfile="logs/hasil_${target//[^a-zA-Z0-9]/_}_$(date +%Y-%m-%d_%H-%M-%S).txt"
        (nmap $nmap_cmd "$target" -oN "$logfile") &
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
    done < "$target_file"

#Ringkasan hasil
    echo -e "${CYAN}📊 Ringkasan Hasil Scan:${NC}"
    echo "============================="

    total=0
    live=0
    open_ports=0

    for filelog in logs/hasil_*.txt; do
        ((total++))
        host=$(basename "$filelog" | sed 's/hasil_//;s/.txt//')
        if grep -q "open" "$filelog"; then
            ((live++))
            ports=$(grep -i open "$filelog" | wc -l)
            open_ports=$((open_ports + ports))
            echo -e "${GREEN}✔️ $host: $ports port terbuka${NC}"
        else
            echo -e "${RED}❌ $host: tidak ada port terbuka${NC}"
        fi
    done

    echo -e "${CYAN}============================="
    echo -e "📦 Total Target   : $total"
    echo -e "✅ Host Aktif     : $live"
    echo -e "🌐 Total Port Open: $open_ports"
    echo -e "=============================${NC}"

    # Opsional: kompres hasil scan
    if compgen -G "Log/hasil_*.txt" > /dev/null
    then
    	read -p "Ingin zip semua hasil scan? (y/n): " ziplog
        zipfile="scan_logs_$(date +%Y%m%d_%H%M).zip"
        zip -rq "$zipfile" logs/
        echo -e "${YELLOW}📁 Semua hasil dikompres ke: $zipfile${NC}"
    fi

# Input target single
scan_single() {
read -p "Masukkan ip/url target: " target
if [[ "$target" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ || "$target" =~ ^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "✅ Format target valid: $target"
    host="$target"
else
    echo "❌ Format target tidak valid!"
    exit 1
fi
}

menu_scan_single() {
  echo -e "${CYAN}Pilih jumlah scan:"
  echo "[1] Scan port tertentu (custom)"
  echo "[2] Scan port umum (1-1000)"
  echo "[3] Full scan (1-65535)"
  read -p "> Pilih [1/2/3]: " mode

  case $mode in
    1)
      read -p "🛠Port apa saja yang ingin anda scan (contoh:22,80,443): " port_input
      [[ -z $port_input ]] && echo -e "${RED}❌Port tidak boleh kosong!${NC}" && exit 1
      nmap_cmd="nmap -p $port_input $host -sV -T4"
      ;;
    2) nmap_cmd="nmap -p 1-1000 $host -sV -T4" ;;
    3) nmap_cmd="nmap -p- $host -sV -T4" ;;
    *) echo -e "${RED}❌Pilihan tidak valid!${NC}" && exit 1 ;;
  esac

  read -p "➕Tambahkan scan lanjutan (script scan & OS detection)? (y/n): " lanjut
  [[ "$lanjut" == "y" ]] && nmap_cmd="$nmap_cmd -sC -sV"

  echo -e "${YELLOW}⚙️Mengecek konektivitas ke target...${NC}"
  if ping -c 2 "$target" &> /dev/null; then
    echo -e "${GREEN}✅Target aktif! Mulai scan...${NC}"
  else
    echo -e "${RED}❓Ping gagal. Lanjutkan scan? (y/n):${NC}"
    read -p "> " lanjut_ping
    [[ "$lanjut_ping" != "y" ]] && echo -e "${RED}❌Scan dibatalkan.${NC}" && exit 1
  fi

  logfile="logs/hasil_${host//[^a-zA-Z0-9]/_}_$(date +%Y-%m-%d_%H-%M-%S).txt"
  echo -e "${CYAN}🚀Menjalankan scan...${NC}"
  $nmap_cmd -oN "$logfile" &
  pid=$!
  spinner $pid
  if [[ -f "$logfile" ]]; then
    echo -e "${GREEN}Scan selesai! File: $logfile${NC}"
    grep -i open "$logfile" | awk '{print "\033[32m"$0"\033[0m"}'
  else
    echo -e "${RED}❌Target tidak aktif atau scan gagal!${NC}"
  fi
}

#menu utama port scanner
echo -e "${CYAN}=== CYBERSCAN v5 ===${NC}"
echo "[1] Scan single target"
echo "[2] Scan multi target"
read -p "Pilih mode scan [1/2]: " pilihan

case $pilihan in
  1)
    scan_single
    menu_scan_single
    ;;
  2)
    scan_multi
    ;;
  *)
    echo -e "${RED}Pilihan tidak valid!${NC}"
    exit 1
    ;;
esac

echo ""

