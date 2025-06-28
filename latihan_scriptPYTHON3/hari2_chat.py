nama = input("Halo bro!Siapa nama lu?" ).title() 

try:
    umur = int(input("Berapa umurmu?" ))
except:
    print("Input harus angka! Coba lagi!! 👊🔥") 
    exit() 

warna = input("Apa warna kesukaanmu?" ).lower().title() 

tahun_lahir = 2025 - umur

print(f"\nWih keren, {nama}! Lo lahir tahun {tahun_lahir} ya?")
print(f"Umur lo {umur} tahun, saat yang tepat buat jadi hacker!")
print(f"Warna kesukaanmu {warna}! keren banget!! 👊")  

if umur >= 15:
    print("Umur lu cukup buat belajar Cybersecurity!💻😎")
else:
    print("Masih muda!, tapi engga masalah buat belajar Cybersecurity! 🔥") 

warna_elite = ["hitam" , "merah", "ungu"]
if warna in warna_elite:
    print(f"{warna} adalah warna elite Hacker! 😎")
else:
    print(f"{warna} juga keren kk! 😎")
