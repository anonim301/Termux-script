import os

file_name = "notes.txt"

def load_notes():
    if not os.path.exists(file_name):
        return []
    with open(file_name,"r")as f:
        notes = [line.strip() for line in f.readline()]
    return notes
    
def save_notes(notes):
    with open(file_name,"w")as f:
        for note in notes:
            f.write(note + "\n")
            
def tampilkan_menu():
    print("\nNOTE KEEPER")
    print("1. Tambah catatan")
    print("2. Lihat catatan")
    print("3. Hapus catatan")
    print("4. Keluar")
    
notes_list = load_notes()

while True:
    tampilkan_menu()
    pilihan = input("Pilih menu (1-4):")
    
    if pilihan == "1":
        note = input("Masukkan catatan:")
        notes_list.append(note)
        save_notes(notes_list)
        print("Catatan ditambahkan")    
    elif pilihan == "2":
        if not notes_list:
            print("Belum ada catatan")
        else:
            print("\nDaftar catatan:")
            for i,note in enumerate(notes_list, start=1):
                print(f"{i}. {note}")             
    elif pilihan == "3":
        if not notes_list:
            print("Tidak ada catatan untuk dihapus")
        else:
            for i,note in enumerate(notes_list, start=1):
                print(f"{i}. {note}")
            try:
                hapus = int(input("Masulkan nomor catatan yang ingin dihapus:"))
                if 1 <= hapus <= len(notes_list):
                    notes_dihapus = notes_list.pop(hapus -1)
                    save_notes(notes_list)
                    print(f"Catatan '{notes_dihapus}' dihapus")
                else:
                    print("Nomor tidak valid")
            except ValueError:
                print("Masukkan angka yang valid")
    elif pilihan == "4":
        print("Keluar dari Note Keeper.Bisa bald!!")
        break
    else:
        print("Pilihan tidak valid.Pilih 1-4 saja!!")
        
                
