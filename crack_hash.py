import hashlib
import time

#Input target hash dari user
target_hash = input("Masukkan hash MD5 yang ingin di-crack: ")

#Wordlist
wordlist = ["admin", "password", "123456", "cyber123", "letmein"]

print("===BRUTE-FORCE HASH===") 

for guess in wordlist:
    hashed_guess = hashlib.md5(guess.encode()).hexdigest() 
    print(f"Mencoba: {guess} --> {hashed_guess}") 
    time.sleep(3)

    if hashed_guess == target_hash:
      print(f"\nSUKSES password ditemukan: {guess}🔓") 
      break
else:
    print("\nPassword tidak ditemukan diwordlist.") 

