#!/bin/bash
# ========================================
# Script      : cyber_whois.py
# Deskripsi   : mencari informasi domain
# Penggunaan  : python cyber_whois.py
# Dibuat oleh : Yanuar
# Tanggal     : 28-07-2025
# ========================================

import whois
import sys
from datetime import datetime

#warna
MERAH = "\033[91m"
HIJAU = "\033[92m"
KUNING = "\033[93m"
BIRU = "\033[94m"
RESET = "\033[0m"

def format_date(value):
	if isinstance(value, list):
		return value[0].strftime("%Y-%m-%d") if value and value[0] else "-"
	elif isinstance(value, datetime):
		return value.strftime("%Y-%m-%d") 
	return "-"

def ambil_data_whois(domain):
	try:
		data = whois.whois(domain) 
		hasil = {
			"Domain name": data.domain_name,
			"Registrar": data.registrar, 
			"Creation date": format_date(data.creation_date),
			"Expiration date": 
format_date(data.expiration_date),
			"Name servers":  data.name_servers, 
			"Status": data.status
		}
		return hasil
	except Exception as e:
		print(f"{MERAH} GAGAL mengambil informasi domain: {e} {RESET}") 
		sys.exit() 

def tampilkan_data(hasil):
	print(f"{BIRU}====HASIL WHOIS===={RESET}") 
	for key, value in hasil.items():
		print(f"{KUNING}{key}:{RESET} {value}") 

def simpan_ke_file(hasil, nama_file):
	try:
		with open(nama_file + ".txt", "w")as file:
			for key, value in hasil.items():
				file.write(f"{key}: {value}\n") 
		print(f"{HIJAU}[+] Hasil disimpan di {nama_file}.txt")
	except Exception as e:
		print(f"{MERAH}[!] GAGAL menyimpan file: {e} {RESET}") 

def main():
	domain = input(f"{BIRU}[!] Masukkan nama domain (contoh:google.com): {RESET}") 
	hasil = ambil_data_whois(domain) 
	tampilkan_data(hasil) 

	simpan = input(f"\nSimpan hasil ke file? (y/n): {RESET}").lower() 
	if simpan == "y":
		nama_file = input(f"Masukkan nama file (tanpa.txt): {RESET}") 
		simpan_ke_file(hasil, nama_file)

if __name__ == "__main__":
	main() 

	
