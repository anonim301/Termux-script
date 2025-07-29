#!/bin/bash

kalkulator() {
	echo "1. Penjumlahan (+)"
	echo "2. Pengurangan (-)"
	echo "3. Perkalian (*)"
	echo "4. Pembagian (/)"
	echo "5. Sisa bagi (%) " 
	echo "6. Pangkat (^) "

	read -p "Masukkan pilihan (1/2/3/4/5/6):" pilihan

	read -p "Masukkan angka pertama:" angka1
	read -p "Masukkan operator (+ - * / % ^): " operator
	read -p "Masukkan angka kedua:" angka2

	case $operator in
		"+"|"-"|"*"|"/"|"%"|"^") 
			hasil=$(echo "$angka1 $operator $angka2" | bc -l) 
			printf "Hasil perhitungan: %.2f\n" $hasil
			;;
		*)
			echo "❌Operator tidak dikenali... "
			;;
	esac
}

while true
do
	echo "===Menu==="
	echo "1. Perhitungan"
	echo "2. Keluar"

	read -p  "Pilih menu (1/2):" pilihan

	if [[ $pilihan -eq 1 ]]
	then
		kalkulator
	elif [[ $pilihan -eq 2 ]]
	then
		echo "Keluar program..."
		exit 1
	else
		echo "Tidak ada dipgram!!... "
	fi
done

echo ""


