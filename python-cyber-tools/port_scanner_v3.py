# ========================================
# Script      : port_scanner_V3.py
# Deskripsi   : Port scanner dengan multithread
# Penggunaan  : python port_scanner_V3.py [target] [-p port_range] [-t threads] [-o output_format]
# Dibuat oleh : Yanuar
# Tanggal     : 18-08-2025
# ========================================

import socket
import threading
import time
import json
import csv
import argparse
from pyfiglet import Figlet
from tqdm import tqdm
import sys

# Warna terminal
HIJAU = "\033[92m"
MERAH = "\033[91m"
RESET = "\033[0m"

# Tampilkan banner
figlet = Figlet(font='digital')
print(MERAH + figlet.renderText("Port Scanner") + RESET)

def cek_koneksi():
    """Cek koneksi internet"""
    try:
        socket.create_connection(("8.8.8.8", 53), timeout=3)
        return True
    except:
        return False

def grab_banner(ip, port):
    """Ambil banner dari port terbuka"""
    try:
        sock = socket.socket()
        sock.settimeout(1)
        sock.connect((ip, port))
        banner = sock.recv(1024).decode().strip()
        sock.close()
        return banner
    except:
        return "N/A"

def parse_args():
    """Parse argumen command line"""
    parser = argparse.ArgumentParser(description='Port Scanner V3')
    parser.add_argument('target', help='Target IP atau Domain')
    parser.add_argument('-p', '--ports', default='1-1024', help='Rentang port (contoh: 20-80)')
    parser.add_argument('-t', '--threads', type=int, default=100, help='Jumlah thread')
    parser.add_argument('-o', '--output', choices=['txt', 'json', 'csv'], default='txt', help='Format output')
    return parser.parse_args()

def pemindai_port(ip_target, port, hasil_terbuka):
    """Fungsi untuk memindai port individual"""
    try:
        koneksi = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        koneksi.settimeout(0.5)
        hasil = koneksi.connect_ex((ip_target, port))
        if hasil == 0:
            try:
                service = socket.getservbyport(port, 'tcp')
            except:
                service = "Unknown"
            
            pesan = f"[+] Port {port} TERBUKA ({service})"
            print(pesan)
            hasil_terbuka.append({
                'port': port,
                'service': service,
                'banner': grab_banner(ip_target, port)
            })
        koneksi.close()
    except Exception as e:
        print(f"Error memindai port {port}: {str(e)}")

def start_scan(target, port_range, thread_count):
    """Mulai proses pemindaian"""
    if not cek_koneksi():
        print(f"{MERAH}❌ Koneksi internet tidak tersedia!{RESET}")
        sys.exit(1)

    try:
        ip_target = socket.gethostbyname(target)
    except socket.gaierror:
        print(f"{MERAH}❌ Gagal resolve domain: {target}{RESET}")
        sys.exit(1)

    awal, akhir = map(int, port_range.split('-'))
    if awal > akhir or awal < 1 or akhir > 65535:
        print(f"{MERAH}❌ Rentang port tidak valid!{RESET}")
        sys.exit(1)

    print(f"\nMemindai {target} ({ip_target}) dari port {awal} sampai {akhir}...\n")
    
    hasil_terbuka = []
    threads = []
    
    start_time = time.time()
    
    with tqdm(total=(akhir - awal + 1), desc='Scanning Ports', unit='port') as pbar:
        for port in range(awal, akhir + 1):
            t = threading.Thread(target=pemindai_port, args=(ip_target, port, hasil_terbuka))
            threads.append(t)
            t.start()
            
            # Batasi jumlah thread yang berjalan bersamaan
            while threading.active_count() > thread_count:
                time.sleep(0.1)
            
            pbar.update(1)
    
    for t in threads:
        t.join()
    
    durasi = time.time() - start_time
    print(f"\n⏳ Durasi pemindaian: {durasi:.2f} detik")
    print(f"\n✅ {HIJAU}Pemindaian selesai!{RESET}")
    
    return hasil_terbuka

def save_results(results, output_format):
    """Simpan hasil pemindaian ke file"""
    if output_format == 'txt':
        with open("hasil_scan.txt", "w") as file:
            for result in results:
                file.write(f"Port {result['port']} ({result['service']}) - Banner: {result['banner']}\n")
        print("📁 Hasil disimpan di hasil_scan.txt")
    
    elif output_format == 'json':
        with open("hasil_scan.json", "w") as file:
            json.dump(results, file, indent=4)
        print("📁 Hasil disimpan di hasil_scan.json")
    
    elif output_format == 'csv':
        with open("hasil_scan.csv", "w", newline='') as file:
            writer = csv.DictWriter(file, fieldnames=['port', 'service', 'banner'])
            writer.writeheader()
            writer.writerows(results)
        print("📁 Hasil disimpan di hasil_scan.csv")

if __name__ == "__main__":
    args = parse_args()
    
    hasil = start_scan(
        target=args.target,
        port_range=args.ports,
        thread_count=args.threads
    )
    
    save_results(hasil, args.output)
