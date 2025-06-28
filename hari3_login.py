#Simulasi login sistem
username_asli = "hacker"
password_asli = "cyber123"
max_attempts = 3

print("=====LOGIN SISTEM=====") 

username_input = input("Username:")
if username_input == username_asli:
    print("Akses diterima!") 
else:
    print("Username tidak terdaftar! ") 

for attempts in range(max_attempts):
  try:
    password_input = input("Masukkan password:")

    if password_input == password_asli:
      print("\nLogin sukses!akses diberikan💻") 
      print("Selamat datang hacker!") 
      break
    else:
      sisa_attempts = max_attempts - (attempts + 1) 
      print(f"Passowrd salah!Sisa percobaan: {sisa_attempts}") 
    if username_input == username_asli and password_input != password_asli:
      print("Password salah! Jawaban hint: password terkait cybersecurity + angka.")

    import time
    if sisa_attempts in (2, 1):
      print("Tunggu selama 5 detik... ") 
      time.sleep(5) 

  except KeyboardInterrupt:
    print("\nDibatalkan oleh user! ") 
    exit() 

else:
    print("\nAkun terkunci! hubungi admin! ") 

