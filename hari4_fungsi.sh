#!/bin/bash 
ucapan_salam() {
  echo "Selamat datang di latihan hari ke 4 fungsi bash! "
}

sapa_nama() {
  echo "Halo, $1 salam kenal! "
}

ucapan_keluar() {
  echo "Sampai jumpa lagi kawan! "
}

while true; do
    echo "===Menu Pilihan==="
    echo "1.Ucapan salam"
    echo "2.Sapa nama"
    echo "3.Keluar"
    read -p "Pilih menu (1/2/3): " pilihan
 if [ $pilihan -eq 1 ] ; then
    ucapan_salam
  elif [ $pilihan -eq 2 ] ; then
    read -p "Masukkan nama: " nama
    sapa_nama "$nama" 
  elif [ $pilihan -eq 3 ] ; then
    ucapan_keluar
    break
  else 
    echo "Pilihan tidak ada diprogram GOBLOKKK! "
 fi
done
