#!/bin/bash

#warna
green="\033[1;32m"
red="\033[1;31m"
blue="\033[1;34m"
reset="\033[1;0m"

echo -e "${blue}===PASSWORD GENERATOR PRO==="

#inpur panjang password
read -p "Masukkan panjang password: " length

#piliham mode
echo -e "${green}Pilih mode:${reset}"
echo "1. Huruf + Angka"
echo "2. Huruf + Angka + Simbol"
echo "3. Hanya angka"
read -p "Pilihan (1/2/3):" mode

#program
case $mode in
	1) chars='A-Za-z0-9' ;;
	2) chars='A-Za-z0-9!@#$%^*()_+=-{}[]<>?' ;;
	3) chars='0-9' ;;
	*) echo -e "${red}Pilihan tidak valid! " && exit 1 ;;
esac

password=$(tr -dc "$chars" < /dev/urandom | head -c $length)
echo -e "\n${green}password kamu:${reset}$password"

#simpan ke file
read -p "Simpen ke file (y/n):" save
if [[ $save == "y" || $save == "Y" ]]
then
	echo "$password" >> password_list.txt
	echo -e "${blue}Password disimpan di file password_list.txt"
fi


	
