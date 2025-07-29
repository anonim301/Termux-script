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
	pilihan = input("Masukkan pilihan:"))
	
	if pilihan in ["1","2","3","4","5","6","7"]
		angka1 = input("Masukkan angka pertama")
		angka2 = input("Masukkan anga kedua")
		
		if pilihan == "1":
			print(f"Hasil: {angka1 + angka2}")
		elif pilihan == "2":
			print(f"Hasil: {angka1 - angka2}")
		elif pilihan == "3":
			print(f"Hasil: {angka1 * angka2}")
		elif pilihan == "4":
			print(f"Hasil: {angka1 / angka2}")
		elif pilihan == "5":
			print(f"Hasil: {angka1 // angka2}")
		elif pilihan == "6":
			print(f"Hasil: {angka1 % angka2}")
		elif plihan == "7":
			print(f"Hasil: {angka1 ** angka2}")
		else:
			print("Tidak ada diprogram!")
			
			
kalkulator()
			
