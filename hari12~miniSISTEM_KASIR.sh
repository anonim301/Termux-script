#!/bin/bash

struk_file="struk_$(date '+%Y-%m-%d_%H-%M-%S').txt"
declare -a nama_barang
declare -a harga_barang
declare -a jumlah_barang

total 0

#Fungsi untuk nambah barang
tambah_barang() {
    read -p "Nama barang: " nama

    read -p "Harga satuan: " harga
    if ! [[ "$harga" =~ ^[0-9]+$ ]]; then
        echo "❌ Harga harus angka!"
        return
    fi

    read -p "Jumlah beli: " jumlah
    if ! [[ "$jumlah" =~ ^[0-9]+$ ]]; then
        echo "❌ Jumlah harus angka!"
        return
    fi

    nama_barang+=($nama)
    harga_barang+=($harga)
    jumlah_barang+=($jumlah)

    subtotal=$((harga * jumlah)) 
    total=$((total + subtotal)) 

    echo "✅Barang '$nama' ditambahkan (Subtotal:$subtotal) "
}

#Fungsu cetak struk ke file
cetak_struk() {
    echo "====STRUK BELANJA====" > "$struk_file"
    for i in "${!nama_barang[@]}"; do
      nama=${nama_barang[$i]}
      harga=${harga_barang[$i]}
      jumlah=${jumlah_barang[$i]}
      subtotal=$((harga * jumlah))

      echo "$nama x$jumlah = $subtotal" >> "$struk_file"
    done
    echo "------------------------------" >> "$struk_file"
    echo "TOTAL : $total" >> "$struk_file"
    echo "==============================" >> "$struk_file"

    echo "🧾 Struk tersimpan di: $struk_file"
}

#Menu utama
while true; do
    echo ""
    echo "======= MENU KASIR ======="
    echo "1. Tambah Barang"
    echo "2. Cetak Struk & Keluar"
    echo "3. Keluar Tanpa Cetak"
    echo "=========================="
    read -p "Pilih menu (1/2/3): " pilihan

    case "$pilihan" in
        1) tambah_barang ;;
        2) cetak_struk; break ;;
        3) echo "❌ Transaksi dibatalkan."; break ;;
        *) echo "Pilihan tidak valid!" ;;
    esac
done

