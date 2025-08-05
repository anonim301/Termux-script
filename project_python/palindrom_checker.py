def bersihkan(teks):
	return''.join(teks.lower().split()) 

print("Palindrom Checker") 
print("-----------------")

while True:
	kata = input("Masukkan kata/kalimat:") 

	teks_bersih = bersihkan(kata) 
	teks_balikkan = teks_bersih[::-1]

	if teks_bersih == teks_balikkan:
		print("✅Ini adalah palindrom!\n ") 
	else:
		print("❌Ini bukan palindrom!\n") 

	ulang = input("Masuk cek kata/kalimat lagi? (y/n):").lower() 

	if ulang != "y":
		print("Fertig! Dankeschön👋👋👋")
		break
		
