#!/bin/bash

#simpah hasil
hasil="hasil_$(date '+%Y-%m-%d_%H-%M-%S').txt"

#banner
figlet -f slant "Konversi Suhu" | lolcat

#menu
while true in
do
	echo "=====MENU KONVERSI SUHU====="
	echo "1. Celsius"
	echo "2. Fahrenheit"
	echo "3. Kelvin"
	echo "4. Keluar"
	read -p "Masukkan pilihan (1/2/3):" pilihan

#input suhu
	if [[ $pilihan -ge 1 && $pilihan -le 3 ]] 
	then
		read -p "Masukkan suhu:" suhu
	fi

#program konversi suhu
	case $pilihan in
		1) 
			#Celcius ke Fahrenheit dan Kelvin
			f=$(echo "scale=2; ($suhu * 9/5) + 32" | bc) 
			k=$(echo "scale=2;$suhu + 273.15" | bc) 
			printf "%s: %.2f°F\n" "$suhu" "$f"
			printf "%s: %.2f°K\n" "$suhu" "$k"
			echo "$suhu: $f°F | $k°K" >> $hasil
			;;
		2)
			#Fahrenheit ke celcius dan kelvin
			c=$(echo "scale=2; ($suhu - 32) * 5/9" | bc) 
			k=$(echo "scale=2; ($suhu - 32) * 5/9 + 273.15" | bc) 
			printf "%s: %.2f°C\n" "$suhu" "$c"
			printf "%s: %.2f°K\n" "$suhu" "$k"
			echo "$suhu: $c°C | $k°K" >> $hasil
			;;
		3) 
			#Kelvin ke celcius dan fahrenheit
			c=$(echo "scale=2; $suhu - 273.15" | bc) 
			f=$(echo "scale=2; ($suhu - 273.15) * 9/5 + 32" | bc) 
			printf "%s: %.2f°C\n" "$suhu" "$c"
			printf "%s: %.2f°F\n" "$suhu" "$f"
			echo "$suhu: $c°C | $f°F" >> $hasil
			;;
		4) 
			echo "Keluar dari program....."
			exit 1
			;;
		*)
			echo "❌Program tidak valid/tidak ada... "
			;;
		esac
done

		
		


