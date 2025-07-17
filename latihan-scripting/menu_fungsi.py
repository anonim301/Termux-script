import os
import getpass
import platform
import time

#function
def show_menu():
	print("====MENU TOOLS===") 
	print("1.Tampilkan tanggal") 
	print("2.Lihat user login") 
	print("3.Lihat sistem") 
	print("4.Cek koneksi internet") 
	print("5.Keluar") 

#looping
while True:
	show_menu() 
	pilih = input("Pilih menu (1/2/3/4/5):") 

	if pilih == "1":
		time.sleep(2) 
		os.system("date") 
	elif pilih == "2":
		time.sleep(2)
		print(f"User login: {getpass.getuser()}") #error f-string
	elif pilih == "3":
		time.sleep(2)
		print(f"Info sistem: {platform.uname()}") 
	elif pilih == "4":
		time.sleep(2)
		print("Cek koneksi internet... ") 
		os.system("ping -c 2 google.com") 
	elif pilih == "5":
		print("Keluar program! byee!... ") 
		break
	else:
		print("Pilihan tidak ada diprogram") 

	print() #baris kosong



