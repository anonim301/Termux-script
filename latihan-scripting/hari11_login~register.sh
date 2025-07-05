#!/bin/bash
user_db="user_db"

#Fungsi untuk register user
register() {
    echo "===REGISTRASI==="
    read -p "Masukkan usernmae baru:" new_user
    if grep -q "^$new_user:" "$user_db"; then
      echo "❗Username sudah digunakan! "
      return
    fi
    read -sp "Masukkan pasword baru:" new_pass
    echo ""
    echo "$new_user:$new_pass" >> "$user_db"
    echo "Registrasi berhasil untuk user '$new_user' "
}

#Fungsi login
login() {
    echo "===LOGIN==="
    read -p "Username: " login_user
    read -sp "Password:" login_pass
    echo ""

    match=$(grep "^$login_user:$login_pass$" "$user_db")
    if [ -n "$match" ]; then
      echo "✅Login berhasil!, selamat datang '$login_user'!! 👊"
      user_menu "$login_user"
     else
      echo "❗Login gagal!!, username dan password salah! 👊"
    fi
}

#Fungsi menu setelah login
user_menu() {
    user="$1"

    while true; do
      echo ""
      echo "========== MENU UTAMA =========="
      echo "👤 User aktif: $user"
      echo "1. Lihat tanggal & waktu"
      echo "2. Cek koneksi internet"
      echo "3. Logout"
      echo "================================"

      read -p "Pilih menu (1/2/3):" pilihan
      case "$pilihan" in
      1) date ;;
      2) ping -c 3 google.com > /dev/null && echo "Online✅" || echo "Offline❗" ;; 
      3) echo "Logout berhasil,Tschüss '$user' !!👋" ; break ;;
      *) echo "❗Pilihan tidak valid! " ;;
    esac
  done
}

#Main menu
while true; do
    echo ""
    echo "======= SISTEM LOGIN HARI 11 ======="
    echo "1. Login"
    echo "2. Registrasi"
    echo "3. Keluar"
    echo "===================================="
    read -p "Pilih menu (1/2/3): " menu

    case "$menu" in
        1) login ;;
        2) register ;;
        3) echo "Sampai jumpa! 👋"; break ;;
        *) echo "❗ Menu tidak ada" ;;
    esac
done


