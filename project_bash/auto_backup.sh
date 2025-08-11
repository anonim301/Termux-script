#!/bin/bash

#folder yang ingin dibakcup
read -p "Masukkan path folder yang ingin dibackup:" folder

#folder tujuan bakcup
read -p "Masukkan path folder tujuan backup:" backup_folder

#Nama file backup dgn timestamp
date=$(date +%Y%m%d_%H%M%S) 
file_name="backup_$(basename "$folder")_$date.tar.gz"

#cek folder tujuan
if [[ ! -d $folder ]] 
then
	echo "❌Folder sumber tidak ditemukan! "
	exit 1
fi

#Cek folder tujuan
if [[ ! -d $backup_folder ]]
then
	echo "Folder tujuan tidak ditemukan, membuat folder..... "
	mkdir -p $backup_folder
fi

#Backup folder
tar -czf "$backup_folder/$file_name" -C "$(dirname "$folder")" "$(basename "$folder")"

if [[ $? -eq 0 ]]
then
	echo "Backup berhasil: $backup_folder/$file_name"
else
	echo "❌Backup gagal!"
fi


