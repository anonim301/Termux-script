import socket

#Target
target = input("Masukkan IP/Domain target: ")

#range port yang ingin discan
start_port = 1
end_port = 100

print(f"[!] Scanning {target} dimulai....")
print(f"\nScan dari port {start_port} sampai {end_port}")

for port in range(start_port, end_port +1):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    socket.setdefaulttimeout(0.5) #waktu scan
    results = s.connect_ex((target, port))
    if results == 0:
        try:
            service = socket.getservbyport(port)
        except:
            service = "Unknown"
        print(f"[OPEN] {port} - {service}")
    s.close()
    
print("\n[+] Scanning selesai")
