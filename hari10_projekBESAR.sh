
#!/bin/bash

log_file="log_kalkulator.txt"
backup_folder="backup_log"

#Fungsi login
login() {
    read -p "Masukkan username:" username
    read -sp "Masukkan passwort:" password
    echo ""

#Contoh login sederhana (nnti bisa pake file database)
  if [[ "$username" = "admin" && $password = "123" ]]; then
    echo "Login anda berhasil!! 👊"
   else
    echo "login gagal"
    exit 1
  fi
}

#fungsi keluar
keluar() {
    echo "Dankeschön tschüss!! ciao!! 👊"
    exit 0
}

#fungsi backup_log (sudah ada)
backup_log() {
    mkdir -p "$backup_folder"
    timestamp=$(date '+%Y-%m-%d_%H-%M-%S') 
    cp "$log_file" "$backup_folder/log_$timestamp"
    echo "Backup selesai ➡️ $backup_folder/log_$timestamp.txt"
}

#Fungsi cek koneksi internet
cek_koneksi() {
    echo "📡🌐 Cek koneksi internet...... "
    ping -c 3 goggle. com &> /dev/null
  if [ $# -eq 0 ]; then
    echo "✅Koneksi internet AKTIF!!✨"
   else
    echo "❗Tidak ada koneksi internet!! 👊"
  fi
}

#Fungsi download file
download_file() {
    read -p "Masukkan URL file yang ingin diunduh:" url
    read -p "Masukkan nama file untuk disimpan(contoh: file.zip): " filename
    curl -o "$filename" "$url"
    echo "✅Download selesai ➡️ $filename"
}

#Fungsi kalkulator
kalkulator() {
    read -p "Masukkan angka pertama: " angka1
    read -p "Masukkan operator (+ - * / % ^ sqrt): " operator
    angka2=""

    if [[ "$operator" != "sqrt" ]]; then
        read -p "Masukkan angka kedua: " angka2
    fi

    case "$operator" in
        "+"|"-"|"*"|"/"|"%"|"^")
            hasil=$(echo "$angka1 $operator $angka2" | bc -l)
            echo "Hasil: $hasil"
            echo "$(date '+%Y-%m-%d %H:%M:%S') ➔ $angka1 $operator $angka2 = $hasil" >> "$log_file"
            ;;
        "sqrt")
            hasil=$(echo "sqrt($angka1)" | bc -l)
            echo "Akar kuadrat dari $angka1: $hasil"
            echo "$(date '+%Y-%m-%d %H:%M:%S') ➔ √$angka1 = $hasil" >> "$log_file"
            ;;
        *)
            echo "❗ Operator tidak dikenali!"
            ;;
    esac
}

#Fungsi konversi suhu
konversi_suhu() {
    read -p "Masukkan suhu dalam Celsius: " celsius
    echo "Pilih konversi:"
    echo "1. Fahrenheit"
    echo "2. Kelvin"
    echo "3. Reamur"
    read -p "Pilihan (1/2/3): " pilihan

    case "$pilihan" in
        1)
            hasil=$(echo "scale=2; (9/5)*$celsius+32" | bc)
            echo "$celsius°C = $hasil°F"
            ;;
        2)
            hasil=$(echo "scale=2; $celsius+273.15" | bc)
            echo "$celsius°C = $hasil°K"
            ;;
        3)
            hasil=$(echo "scale=2; (4/5)*$celsius" | bc)
            echo "$celsius°C = $hasil°Re"
            ;;
        *)
            echo "❗ Pilihan konversi tidak valid!"
            ;;
    esac
}

#Fungsi menu
menu() {
    echo ""
    echo "=========== MENU =========="
    echo "1. Kalkulator"
    echo "2. Konversi Suhu"
    echo "3. Backup Log"
    echo "4. Cek Koneksi Internet"
    echo "5. Download File"
    echo "6. Keluar"
    echo "==========================="
}

# Program Utama
login

while true; do
    menu
    read -p "Pilih menu (1/2/3/4/5/6): " pilihan

    case "$pilihan" in
        1) kalkulator ;;
        2) konversi_suhu ;;
        3) backup_log ;;
        4) cek_koneksi ;;
        5) download_file ;;
        6) keluar ;;
        *) echo "❗ Pilihan tidak ada di program!! 👊" ;;
    esac
done





