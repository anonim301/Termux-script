# ========================================
# Script      : port_scanner_V2.py
# Deskripsi   : Port scanner dengan multithread
# Penggunaan  : python port_scanner_V2.py
# Dibuat oleh : Yanuar
# Tanggal     : 7-08-2025
# ========================================


import socket
import threading
import time
import json
from pyfiglet import Figlet

#Warna terminal
HIJAU = "\033[92m"
MERAH = "\033[91m"
RESET = "\033[0m"

#simpan hasil
hasil_terbuka = []

# Tampilkan banner
figlet = Figlet(font='digital')  # kamu bisa coba font lain juga
print(MERAH + figlet.renderText("Port Scanner") + RESET)

#variabel
target = input("Masukkan IP atau domain target: ")
port_range = input("Masukkan rentang port (contoh: 20-80): ")

#cek koneksi internet
def cek_koneksi():
	try:
		socket.create_connection(("8.8.8.8", 53), timeout=3) 
		return True
	except:
		return False

if not cek_koneksi():
	print("❌Koneksi OFFLINE") 
	sys.exit() 

#deketsi akurat
def grab_banner(ip, port):
    try:
        sock = socket.socket()
        sock.settimeout(1)
        sock.connect((ip, port))
        banner = sock.recv(1024).decode().strip()
        sock.close()
        return banner
    except:
        return "N/A"

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
				try:
					service = socket.getservbyport(port)
				except:
					service = "Unknown"

				pesan = f"[+] Port {port} TERBUKA ({service})"
				print(pesan) 
				hasil_terbuka.append(pesan) 
			
				banner = grab_banner(ip_target, port) 
				if banner != "N/A":
					print(f"    ↪ Banner: {banner}")
			except:
				pass
			finally:
				koneksi.close() 
	except:
		pass

#Validasi input rentang port
if awal > akhir or awal < 1 or akhir > 65535:
	print(f"{MERAH}❌ Rentang port tidak valid!{RESET}") 

#waktu scanning
mulai = time.time() #timer dimulai saat scan

#Multittasking
threads = []
for port in range(awal, akhir + 1):
	t = threading.Thread(target=pemindai_port, args=(port,))
	threads.append(t)
	t.start()

for t in threads:
	t.join()

#timer berhenti ketika selesai scan
selesai = time.time() 
durasi = selesai - mulai
print(f"\n⏳Durasi: {durasi: .2f} detik") 

print(f"\n✅ {HIJAU}Pemindaian selesai!{RESET}")

#simpan hasil scan
with open("hasil_scan.txt", "w")as file:
	for line in hasil_terbuka:
		file.write(line + "\n")
	print(f"\n📁Hasil disimpan di hasil_scan.txt ")

#simpan ke csv/json
with open("hasil_scan.json", "w")as file:
	json.dump(hasil_terbuka, file, indent=4) 
	print(f"\n📁Hasil disimpan di hasil_scan.json") 


