#!/bin/bash
# ========================================
# Script      : cyber_whois_v2.py
# Deskripsi   : mencari informasi domain
# Penggunaan  : python cyber_whois_v2.py
# Dibuat oleh : Yanuar
# Tanggal     : 28-07-2025
# ========================================

import whois
import sys
import socket
import csv
import json
from datetime import datetime

#warna
MERAH = "\033[91m"
HIJAU = "\033[92m"
KUNING = "\033[93m"
BIRU = "\033[94m"
RESET = "\033[0m"

#cek koneksi
def cek_koneksi():
        try:
                socket.create_connection(("8.8.8.8", 53), timeout=3)
                return True
        except:
                return False

if not cek_koneksi():
        print("❌Koneksi OFFLINE")
        sys.exit()

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
        with open(nama_file + ".txt", "w") as file:
            if isinstance(hasil, list):
                for idx, data in enumerate(hasil, start=1):
                    file.write(f"=== Domain ke-{idx} ===\n")
                    for key, value in data.items():
                        if isinstance(value, list):
                            file.write(f"{key}:\n")
                            for item in value:
                                file.write(f"  - {item}\n")
                        else:
                            file.write(f"{key}: {value}\n")
                    file.write("\n")
            else:
                # kalau hanya satu domain (dict)
                for key, value in hasil.items():
                    if isinstance(value, list):
                        file.write(f"{key}:\n")
                        for item in value:
                            file.write(f"  - {item}\n")
                    else:
                        file.write(f"{key}: {value}\n")

        print(f"{HIJAU}[+] Hasil disimpan di {nama_file}.txt")

        with open(nama_file + ".json", "w") as file:
            json.dump(hasil, file, indent=4, ensure_ascii=False)

        print(f"{HIJAU}[+] Hasil disimpan di {nama_file}.json{RESET}")

    except Exception as e:
        print(f"{MERAH}[!] GAGAL menyimpan file: {e} {RESET}")
             
def main():
        hasil_list = []

        pilihan_input = input(f"{BIRU}Mau input manual (m) atau dari file (f)? {RESET}").lower()

        if pilihan_input == "m":
                domain = input(f"{BIRU}[!] Masukkan nama domain (contoh:google.com): {RESET}")
                hasil = ambil_data_whois(domain)
                tampilkan_data(hasil)
                hasil_list.append(hasil)
        elif pilihan_input == "f":
                nama_file = input(f"{BIRU}[!] Masukkan nama file yang berisi target domain: {RESET}")
                try:
                        with open(nama_file, "r")as f:
                                for domain in f:
                                        domain = domain.strip()
                                        if domain:
                                                hasil = ambil_data_whois(domain)
                                                tampilkan_data(hasil)
                                                hasil_list.append(hasil)
                except:
                        print(f"{MERAH}❌File tidak ditemukan! ")
                        sys.exit()
        else:
                print(f"{MERAH}❌Pilihan tidak vali!{RESET}")
                return

        simpan = input(f"\nSimpan hasil ke file? (y/n): {RESET}").lower()
        if simpan == "y":
                nama_file = input(f"Masukkan nama file (tanpa.txt): {RESET}")
                simpan_ke_file(hasil_list if pilihan_input == "f" else hasil, nama_file)

if __name__ == "__main__":
        main()
