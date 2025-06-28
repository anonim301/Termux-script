#!/bin/bash
echo "🛡️ Selamat datang di CyberScript!"
read -p "Masukkan username: " username
read -p "Masukkan email: " email
echo "Username: $username" > user_info.txt
echo "Email: $email" >> user_info.txt
echo "✅ Data tersimpan di user_info.txt!"
