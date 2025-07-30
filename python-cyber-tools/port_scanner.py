#!/bin/bash
# ========================================
# Script      : port_scanner.py
# Deskripsi   : Port scanner dengan multithread
# Penggunaan  : python port_scanner.py
# Dibuat oleh : Yanuar
# Tanggal     : 28-07-2025
# ========================================


import socket
import threading
from pyfiglet import Figlet

#Warna terminal
HIJAU = "\033[92m"
MERAH = "\033[91m"
RESET = "\033[0m"

# Tampilkan banner
figlet = Figlet(font='digital')  # kamu bisa coba font lain juga
print(MERAH + figlet.renderText("Port Scanner") + RESET)
#variabel
target = input("Masukkan IP atau domain target: ")
port_range = input("Masukkan rentang port (contoh: 20-80): ")

#Coba resolve domain ke IP
try:
	ip_target = socket.gethostbyname(target)
except socket.gaierror:
	print(f"{MERAH}❌ Gagal menyelesaikan nama domain: {target}{RESET}")
	exit()

#Rentang port
awal, akhir = map(int, port_range.split("-"))

print(f"\nMemindai {target} ({ip_target}) dari port {awal} sampai {akhir}...\n")

#Fungsi pemindaian
def pemindai_port(port):
	try:
		koneksi = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		koneksi.settimeout(0.5)
		hasil = koneksi.connect_ex((ip_target, port))
		if hasil == 0:
			try:
				service = socket.getservbyport(port)
			except:
				service = "Unknown"
			print(f"{HIJAU}[+] Port {port} TERBUKA ({service}){RESET}")
			koneksi.close()
	except:
		pass

#Multittasking
threads = []
for port in range(awal, akhir + 1):
	t = threading.Thread(target=pemindai_port, args=(port,))
	threads.append(t)
	t.start()

for t in threads:
	t.join()

print(f"\n✅ {HIJAU}Pemindaian selesai!{RESET}")


