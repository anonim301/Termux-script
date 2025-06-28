#!/bin/bash
while true; do
    echo "===Menu Pilihan==="
    echo "1.Salam kenal"
    echo "2.Ucapkan salam"
    echo "3.Keluar!"
    read -p "Pilih menu (1/2/3): " pilihan
  if [ $pilihan -eq 1 ] ; then
    read -p "masukkan nama: "  nama
    echo "Halo, $nama salam kenal!"
  elif [ $pilihan -eq 2 ] ; then
   echo "Selamat datang ini hari 3 belajar looping bash"
  elif [ $pilihan -eq 3 ] ; then
    echo "Sampai jumpa lagi kawan!"
   break
  else
    echo "Tidak ada di Program!"
 fi

done
