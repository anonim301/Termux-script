# 🛡️ python-cyber-tools

Kumpulan tools berbasis Python untuk **cybersecurity**, **OSINT**, dan **otomatisasi**.


## 📂 Tools yang Tersedia
1.`cyber_whois.py` → 
- Cek domain name, registrar, tanggal buat & expired
- Tampilkan name server dan email kontak
- Deteksi error jika domain tidak valid

2.cyber_whois_v1.py
- Handling error lebih kuat (try-except) untuk domain invalid atau data kosong
- Output lebih rapi dan berwarna menggunakan ANSI escape codes
- Penambahan fitur penyimpanan hasil ke file .txt
- Struktur kode lebih modular dan siap diintegrasikan ke tools cyber lain
- Penggunaan fungsi isinstance() untuk validasi hasil WHOIS

3.cyber_whois_v2.py
- Cek Koneksi Otomatis — memastikan target domain dapat diakses sebelum eksekusi WHOIS.
- WHOIS Multi Target — bisa memproses banyak domain sekaligus langsung dari file .txt.
- Export Data — hasil scan bisa disimpan ke format .json atau .csv untuk analisis lanjutan.
- Optimasi Kecepatan — pemrosesan lebih cepat berkat threading yang ditingkatkan.

4.'port_scanner.py'
- Input domain atau IP target
- Input rentang port (contoh: 20-80)
- Resolusi domain ke IP
- Deteksi port terbuka & nama servicenya
- Output berwarna untuk status port
- Banner keren dengan `pyfiglet`
- Multithread (lebih cepat)

5.'port_scanner_v1.py'
- Validasi input rentang port
- Tampilkan hasil scan ke terminal & penyimpanan file
- Penghitungan waktu scanning
- Handling error ketika resolve IP Domain

6.'port_scanner_v2.py'
- Banner grabbing untuk deteksi layanan secara lebih akurat
- Cek koneksi internet sebelum scanning
- Hasil scan bisa diexport ke CSV & JSON

7.'port_scanner_v3.py'
- Command-Line Arguments → mendukung penggunaan fleksibel (target, range port, jumlah threads, serta format output dapat dikonfigurasi langsung via CLI).

- Progress Bar dengan Estimasi Waktu → memberikan feedback visual yang interaktif sehingga proses scanning lebih transparan dan informatif.

- Enhanced Service Detection & Banner Grabbing → mampu mengidentifikasi layanan dengan lebih akurat, bahkan jika berjalan di port non-standar, serta menampilkan informasi banner yang lebih lengkap.

  

## 🚀 Cara Pakai
```bash
git clone https://github.com/kamu/python-cyber-tools.git
cd python-cyber-tools/<nama-folder>
python <nama-script>.py


## 📄 Lisensi
Distribusi tools ini menggunakan MIT License. Lihat file LICENSE untuk detail.


## ⚠️ Disclaimer
Tools ini dibuat untuk tujuan edukasi, pengujian keamanan yang sah, dan otomatisasi yang legal.  
Penggunaan tools ini untuk aktivitas ilegal atau tanpa izin adalah tanggung jawab pengguna.  
Pengembang tidak bertanggung jawab atas penyalahgunaan atau konsekuensi yang ditimbulkan.
