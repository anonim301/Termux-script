import os
import shutil

# Mapping ekstensi ke folder
FOLDER_MAP = {
    "Gambar": [".jpg", ".jpeg", ".png", ".gif"],
    "Dokumen": [".pdf", ".docx", ".txt", ".xlsx"],
    "Musik": [".mp3", ".wav", ".flac"],
    "Video": [".mp4", ".mkv", ".avi"],
    "Arsip": [".zip", ".rar", ".tar", ".gz"],
    "Python": [".py"],
    "Lainnya": []  # fallback kalau gak masuk kategori
}

def buat_folder(base_path):
    """Buat folder sesuai mapping kalau belum ada."""
    for folder in FOLDER_MAP.keys():
        os.makedirs(os.path.join(base_path, folder), exist_ok=True)

def organize_files(base_path):
    """Pindahin file sesuai ekstensi ke folder masing-masing."""
    buat_folder(base_path)
    
    for item in os.listdir(base_path):
        item_path = os.path.join(base_path, item)

        # Skip folder supaya nggak pindah foldernya sendiri
        if os.path.isdir(item_path):
            continue

        ext = os.path.splitext(item)[1].lower()
        moved = False

        for folder, extensions in FOLDER_MAP.items():
            if ext in extensions:
                shutil.move(item_path, os.path.join(base_path, folder, item))
                print(f"✅ {item} → {folder}/")
                moved = True
                break
        
        if not moved:  # kalau ekstensi ga dikenal
            shutil.move(item_path, os.path.join(base_path, "Lainnya", item))
            print(f"📂 {item} → Lainnya/")

if __name__ == "__main__":
    path = input("Masukkan path folder (misal: /sdcard/Download): ").strip()

    if not os.path.exists(path):
        print("❌ Path tidak ditemukan!")
    else:
        organize_files(path)
        print("\n✨ Semua file sudah dirapikan!")
