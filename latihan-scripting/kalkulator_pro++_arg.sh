#!/bin/bash

log_file="log_kalkulator.txt"

keluar() {
    echo "Terima kasih, sampai jumpa!"
    exit 0
}

log_hasil() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$log_file"
}

cek_angka() {
    if ! [[ "$1" =~ ^-?[0-9]+([.][0-9]+)?$ ]]; then
        echo "Error: '$1' bukan angka yang valid!"
        return 1
    fi
    return 0
}

kalkulator() {
    cek_angka "$angka1" || return
    
    if [ "$operator" != "sqrt" ]; then
        cek_angka "$angka2" || return
    fi

    if [ "$operator" = "/" ] && [ "$angka2" = "0" ]; then
        echo "Error: Tidak bisa membagi dengan 0!"
        return
    fi

    case "$operator" in
        "+"|"-"|"*"|"/"|"%"|"^")
            hasil=$(echo "scale=2; $angka1 $operator $angka2" | bc -l)
            echo "Hasil: $hasil"
            log_hasil "$angka1 $operator $angka2 = $hasil"
            ;;
        "sqrt")
            hasil=$(echo "scale=2; sqrt($angka1)" | bc -l)
            echo "Akar kuadrat dari $angka1 = $hasil"
            log_hasil "sqrt($angka1) = $hasil"
            ;;
        *)
            echo "Error: Operator tidak dikenali! Gunakan + - * / % ^ sqrt"
            ;;
    esac
}

konversi_suhu() {
    cek_angka "$angka1" || return
    
    case "$operator" in
        "toF")
            hasil=$(echo "scale=2; ($angka1 * 9/5) + 32" | bc -l)
            echo "$angka1°C = $hasil°F"
            log_hasil "$angka1°C → $hasil°F"
            ;;
        "toK")
            hasil=$(echo "scale=2; $angka1 + 273.15" | bc -l)
            echo "$angka1°C = $hasil K"
            log_hasil "$angka1°C → $hasil K"
            ;;
        "toR")
            hasil=$(echo "scale=2; $angka1 * 4/5" | bc -l)
            echo "$angka1°C = $hasil°Re"
            log_hasil "$angka1°C → $hasil°Re"
            ;;
        *)
            echo "Error: Format konversi salah! Gunakan: toF, toK, toR"
            ;;
    esac
}

# Program utama
if [ "$1" = "keluar" ]; then
    keluar
fi

if [ $# -lt 2 ]; then
    echo "Cara penggunaan:"
    echo "  Operasi dasar: $0 <angka1> <operator> <angka2>"
    echo "  Contoh: $0 5 + 3"
    echo "  Akar kuadrat: $0 9 sqrt"
    echo "  Konversi suhu: $0 <angka> toF|toK|toR"
    echo "  Keluar: $0 keluar"
    exit 1
fi

angka1=$1
operator=$2
angka2=$3

if [[ "$operator" =~ ^(toF|toK|toR)$ ]]; then
    konversi_suhu
else
    kalkulator
fi

while true; do
    echo ""
    read -p "Masukkan perhitungan baru (atau ketik 'keluar'): " input

    if [ "$input" = "keluar" ]; then
        keluar
    fi

    set -- $input
    angka1=$1
    operator=$2
    angka2=$3

    if [[ "$operator" =~ ^(toF|toK|toR)$ ]]; then
        konversi_suhu
    else
        kalkulator
    fi
done
