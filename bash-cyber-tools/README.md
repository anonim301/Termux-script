---

🛠️ Bash Cyber Tools

Kumpulan tools cybersecurity berbasis Bash yang dibuat sepenuhnya di Termux (Android) sebagai bagian dari perjalanan belajar mandiri saya dalam scripting Bash dan ethical hacking.
Tools ini terus dikembangkan seiring bertambahnya pengalaman saya.


---

📁 Daftar Tools

🔹 cyberscan.sh

Port scanner sederhana menggunakan Nmap

Cek ping + scan port

Output realtime + hasil otomatis disimpan


🔹 cyberscan_V1.sh

Versi yang lebih baik dengan fitur:

Validasi input

Output terminal berwarna

Log otomatis diberi nama sesuai waktu

Bisa melihat log dengan less


🔹 cyberscan_V2.sh

Scanner interaktif:

Mode scan: custom / top 1000 / full

Auto ping + deteksi service

Log otomatis disimpan di folder /logs

Port terbuka ditandai warna hijau


🔹 cyberscan_V3.sh

Upgrade besar pada tampilan:

Validasi IP/domain dengan regex

Pilihan untuk melanjutkan scan (misalnya Cloudflare)

Banner keren + loading spinner

Opsional scan lanjutan dengan -sC


🔹 cyberscan_V4.sh

Fokus pada kemudahan penggunaan + otomatisasi:

Multi-target scanning dari file

Pengecekan format input dan file

Penamaan log unik

Mode advanced scan opsional


🔹 cyberscan_V5.sh

Versi terbaru (sepenuhnya otomatis):

Multi-target scanning paralel

Laporan ringkasan dibuat otomatis

Log otomatis dikompres (zip)


🔹 cyberwhois.sh

Lookup informasi WHOIS

Hasil otomatis disimpan ke file .txt

Auto-install whois jika belum ada

Menampilkan ringkasan singkat di terminal


🔹 cyberwhois_v1.sh

Validasi dan lookup 1 domain atau banyak domain dari file

Cek koneksi internet + validasi input

Output disimpan dengan nama file berdasarkan timestamp

Highlight info penting WHOIS (registrar, tanggal dibuat, tanggal kedaluwarsa, dll.)


🔹 port_scanner_pro.sh | script sederhana tapi powerful |

Input bisa 1 host/IP atau file berisi banyak host

Bisa menentukan range port (default: 1–1024)

Threading untuk mempercepat scan (default: 50 concurrent threads)

Output hasil otomatis tersimpan dalam format CSV per host

Identifikasi port yang terbuka (OPEN)



---

📌 Catatan

Ramah untuk pengguna mobile

Tidak perlu akses root

100% dibuat di Termux

Cocok untuk pemula dalam cybersecurity dan scripting



---

📄 Lisensi

Tools ini menggunakan MIT License. Lihat file LICENSE untuk detail lebih lanjut.


---

⚠️ Disclaimer

Tools ini dibuat hanya untuk tujuan edukasi, pengujian keamanan legal, dan otomatisasi yang sah.
Penggunaan untuk aktivitas ilegal atau tanpa izin sepenuhnya menjadi tanggung jawab pengguna.
Pengembang tidak bertanggung jawab atas penyalahgunaan maupun konsekuensi yang ditimbulkan.


---
