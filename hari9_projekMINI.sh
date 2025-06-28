#!/bin/bash

log_file="log_kalkulator.txt"
backup_folder="backup_log"

keluar() {
    echo "Vielen dank!! Ciao!! 👊"
    exit 0
}

log_hasil() {
     echo "$(date '+%Y-%m-%d %H:%M:%S' ) ➡ $1" >> "log_file"
}

cek_angka() {
  if ! [[ "$1" =~ ^-?[0-9]+([.][0-9]+)?$ ]]; then
    echo "! '$1' bukan angka yang valid! "
    return 1
  fi
  return 0
}

kalkulator() {
    read -p "Masukkan angka pertama: " angka1
    cek_angka "$angka1" || return
    
    read -p " Masukan operator (+ - * / % ^ sqrt): " operator
    
    read -p "Masukkan angka kedua: " angka2
    cek_angka "$angka2" || return

case "$operator" in
    "+"|"-"|"*"|"/"|"%"|"^")
    hasil=$(echo "$angka1 $operator $angka2" | bc -l )
    echo "Hasil:$hasil"
    log_hasil "$angka1 $operator $angka2:$hasil"
    ;;
  "sqrt") 
    hasil=$(echo "sqrt($angka1) " | bc -l ) 
    echo "Akar kuadrst dari $angka1 = $hasil"
    log_hasil "sqrt($angka1) = $hasil"    
    ;;
  *)
    echo "! Operator tidak dikenali! Gunakan hanya + - * / % ^ sqrt"
    ;;
  esac
}

konversi_suhu() {
    read -p "Masukkan suhu dalam Celsius: " angka1
    cek_angka "$angka1" || return
    echo "Pilih konversi:"
    echo "1. Fahrenheit"
    echo "2. Kelvin"
    echo "3. Reamur"
    read -p "Pilihan (1/2/3): " pilih

  case "$pilih" in
    1)

      hasil=$(echo "scale=2; ($angka1 * 9/5 + 32)" | bc -l ) 
      echo "$angka1°C = $hasil°F "
      log_hasil "$angka1°C ➡ $hasil°F"
      ;;

    2)

      hasil=$(echo "scale=2; $angka1 + 273.15" | bc -l ) 
      echo "$angka1°C = $hasil°K"
      log_hasil "$angka1°C ➡️ $hasil°K"
      ;;

    3)

      hasil=$(echo "scale=2; $angka1 * 4/5 " | bc -l )
      echo "$angka1°C = $hasil°Re"
      log_hasil "$angka1°C➡️$hasil°Re"
      ;;
    *)
      echo "Pilihan salah!! 👊"
      ;;

  esac
}

backup_log() {
    mkdir -p "$backup_folder"
    timestamp=$(date '+%Y-%m-%d_%H-%M-%S') 
    cp "$log_file" "$backup_folder/log_$timestamp.txt"
    echo "Backup selesai ➡️ $backup_folder/log_$timestamp.txt"
}

menu() {
    echo ""
    echo "=========== MENU ==========="
    echo "1. Kalkulator"
    echo "2. Konversi Suhu"
    echo "3. Backup Log"
    echo "4. Keluar"
    echo "============================"
}

while true; do
    menu
    read -p "Pilih menu (1/2/3/4): " pilihan
  case "$pilihan" in
    1) kalkulator ;;
    2) konversi_suhu ;;
    3) backup_log ;;
    4) keluar ;;
    *) echo "Pilihan tidak ada diprogram!! 👊" ;;
  esac
done

