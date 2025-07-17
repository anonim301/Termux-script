import os

#input
ip = input("Masukkan IP/Domain:") 
response = os.system(f"ping -c 2 {ip} > /dev/null") 

#loop
if response == 0:
	print(f"✅Host {ip} aktif!") 
else:
	print(f"❗Host {ip} tidak aktif!") 

