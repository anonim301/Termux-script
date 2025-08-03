import datetime

print("BMI (Body Mass Index) Calculator")
print("--------------------------------")

while True:
    try:
        berat = float(input("Masukkan berat badan(kg):"))
        tinggi_cm = float(input("Masukkan tinggi badang(cm):"))
        tinggi_m = tinggi_cm / 100
        bmi = berat / (tinggi_m ** 2)
        
        print(f"\nBMI anda: {bmi:.2f}")
        
        if bmi < 18.5:
            print("Kategori: Kurus(Underweight)")
        elif bmi < 25:
            print("Kategori: Normal")
        elif bmi < 30:
            print("Kategori: Kelebihan berat badan(overweight)")
        else:
            print("Kategori: Obesitas")
        
        ulang = input("\nCek BMI lagi? (y/n):").lower()
        
        if ulang != "y":
            print("Vielen dank sudah menggunakan BMI calculator")
            break
    
    except ValueError:
        print("\nTidak ada diprogram/perintah tidak valid!")
 
with open("hasil_BMI.txt", "a")as f:
	waktu = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
	f.write(f"{waktu} | bmi anda: {bmi:.2f}")
print("Hasil bmi disimpan di hasil_BMI.txt\n")
