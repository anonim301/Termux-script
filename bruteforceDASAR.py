import time

#Target password (bisa diganti)
target_password = input("Masukkan password yang ingin di-crack:") 

#Baca wordlist
with open("wordlist.txt") as file:
    wordlist = file.read().splitlines()

print("===BRUTE-FORCE SIMULATOR===") 

#Loop untuk mencoha setiap password
for guess in wordlist[:7]:
    print(f"Mencoba: {guess}") 
    time.sleep(1) #Delay

    if guess == target_password:
      print(f"\nSUKSES! password ditemukan: {guess}🔓") 
      break
else:
    print("\nGAGAL!  Password tidak ada di wordlist. ") 

