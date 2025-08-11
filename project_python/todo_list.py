import os

FILE_NAME = "todo_list.txt"

def load_tasks():
    if not os.path.exists(FILE_NAME):
        return []
    with open(FILE_NAME, "r") as f:
        tasks = [line.strip() for line in f.readlines()]
    return tasks

def save_tasks(tasks):
    with open(FILE_NAME, "w") as f:
        for task in tasks:
            f.write(task + "\n")

def tampilkan_menu():
    print("\n📋 TO-DO LIST")
    print("1. Tambah Tugas")
    print("2. Lihat Tugas")
    print("3. Hapus Tugas")
    print("4. Keluar")

todo_list = load_tasks()

while True:
    tampilkan_menu()
    pilihan = input("Pilih menu (1-4): ")

    if pilihan == "1":
        tugas = input("📝 Masukkan tugas: ")
        todo_list.append(tugas)
        save_tasks(todo_list)
        print("✅ Tugas ditambahkan.")

    elif pilihan == "2":
        if not todo_list:
            print("📭 Belum ada tugas.")
        else:
            print("\n📋 Daftar Tugas:")
            for i, tugas in enumerate(todo_list, start=1):
                print(f"{i}. {tugas}")

    elif pilihan == "3":
        if not todo_list:
            print("❌ Tidak ada tugas untuk dihapus.")
        else:
            for i, tugas in enumerate(todo_list, start=1):
                print(f"{i}. {tugas}")
            try:
                hapus = int(input("Masukkan nomor tugas yang ingin dihapus: "))
                if 1 <= hapus <= len(todo_list):
                    tugas_dihapus = todo_list.pop(hapus - 1)
                    save_tasks(todo_list)
                    print(f"🗑️ Tugas '{tugas_dihapus}' dihapus.")
                else:
                    print("❌ Nomor tidak valid.")
            except ValueError:
                print("❌ Masukkan angka yang valid.")

    elif pilihan == "4":
        print("👋 Keluar dari To-Do List. Sampai jumpa!")
        break

    else:
        print("❌ Pilihan tidak valid. Pilih 1-4.")
