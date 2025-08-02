import datetime

def kalkulator():
	print("Pilih operasi")
	print("1. Penjumlahan")
	print("2. Pengurangan")
	print("3. Perkalian")
	print("4. Pembagian")
	print("5. Pembulatan")
	print("6. Sisa bagi")
	print("7. Pangkat")
	
	#input
	pilihan = input("Masukkan pilihan:")
	
	if pilihan in ["1","2","3","4","5","6","7"]:
		angka1 = float(input("Masukkan angka pertama:"))
		operator = input("Masukkan operator (+, -, *, /, //, %, **):") 
		angka2 = float(input("Masukkan anga kedua:"))
		
		if pilihan == "1":
			hasil = (f"Hasil: {angka1 + angka2}")
			print(hasil) 
		elif pilihan == "2":
			hasil = (f"Hasil: {angka1 - angka2}")
			print(hasil) 
		elif pilihan == "3":
			hasil = (f"Hasil: {angka1 * angka2}")
			print(hasil) 
		elif pilihan == "4":
			hasil = (f"Hasil: {angka1 / angka2}")
			print(hasil) 
		elif pilihan == "5":
			hasil = (f"Hasil: {angka1 // angka2}")
			print(hasil) 
		elif pilihan == "6":
			hasil = (f"Hasil: {angka1 % angka2}")
			print(hasil) 
		elif plihan == "7":
			hasil = (f"Hasil: {angka1 ** angka2}")
			print(hasil) 
		else:
			print("Tidak ada diprogram!")

			#simpan file 
		with open("hasil.txt", "a")as file:
			waktu = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
			file.write(f"{waktu} | {angka1} {operator} {angka2}: {hasil} \n")  

kalkulator() 
