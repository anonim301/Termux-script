#!/bin/bash

echo "Advanced Port Scanner"

#fungsi cek tools
check_tools() {
   if command -v nc > /dev/null 2>&1
  then
    TOOL="nc"
  elif command -v nmap > /devl/null 2>&1
  then
    TOOL="nmap"
  else
    echo "Nc atau nmap tidak ditemukan! Instal dulu..."
    exit 1
  fi  
}

#fungsi scan nc
scan_with_nc() {
  echo "\nMulai scan dengan netcat(TCP) ke $target..."
  for ((port=START; port<=END; port++))
  do
    timeout 1 bash -c "echo >/dev/tcp/$target/$port" 2>/dev/null && 
      echo "Port $port TERBUKA" ||
      echo "Port $port TERTUTUP"
  done
}

#fungsi scan pake nmap
scan_with_nmap() {
  PROTO_FLAG="-sT"
  if [[ $PROTO == "udp" ]] 
  then
    PROTO_FLAG="-sU"
  fi
  echo "\nMulai scan dengan nmap ($PORTO) ke $target..."
  nmap $PROTO_FLAG -p $START - $END $target
}

#input user
read -p "Masukkan IP/Domain target:" target
read -p "Masukkan port awal:" START
read -p "Masukkan port akhir:" END
read -p "Protokol (tcp/udp):" PROTO

check_tools

#Scan sesuai tools
if [[ $TOOL == "nc" && $PROTO == "tcp" ]]
then
	scan_with_nc | tee "hasil_scan_$target_$(date +%s).txt"
else
	scan_with_nmap | tee "hasil_scan_$target_$(date +%s).txt"
fi

echo "\nSelesai. Hasil disimpan di file.... "


