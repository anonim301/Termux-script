import random
import datetime

#komputer pilih angka secara random
angka_rahasia = random.randint(1,100)
percobaan = 0
max = 8
point = ["100", "90","80","70","60", "50", "40","30"]

#input
print("Selamat datang ditebak angka")
print("Saya sudah memlih angka dari 1 sampai 100")
print("Coba tebak ya\n")

#loop
while percobaan < max:
	try:
		#input program
		tebakan = int(input("Masukkan angka tebakanmu:"))
		percobaan += 1

		#poin percobaan
		print(f"Point: {point[percobaan -1]}")

		if tebakan < angka_rahasia:
			print("Terlalu kecil\n")
		elif tebakan > angka_rahasia:
			print("Terlalu besar\n")
		else:
			print(f"[BENAR] Kamu berhasil menebak: {angka_rahasia}")
			print(f"Kamu menebak dalam percobaan: {percobaan}")
			break
	except ValueError:
		print("Tidak ada diprogram")

if percobaan == max:
	print(f"[GAGAL] Percobaan sudah limit!!!!: {max}") 

#Simpan hasil skor 
with open("skor.txt", "a")as file:
	waktu = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S") 
	file.write(f"waktu | jawaban: {angka_rahasia} | percobaan: {percobaan} | point: {point[percobaan -1]}\n") 

	
