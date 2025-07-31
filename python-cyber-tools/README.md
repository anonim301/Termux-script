# 🛡️ python-cyber-tools

Kumpulan tools berbasis Python untuk **cybersecurity**, **OSINT**, dan **otomatisasi**.


## 📂 Tools yang Tersedia
1.`cyber_whois.py` → 
- Cek domain name, registrar, tanggal buat & expired
- Tampilkan name server dan email kontak
- Deteksi error jika domain tidak valid

2.'port_scanner.py'
- Input domain atau IP target
- Input rentang port (contoh: 20-80)
- Resolusi domain ke IP
- Deteksi port terbuka & nama servicenya
- Output berwarna untuk status port
- Banner keren dengan `pyfiglet`
- Multithread (lebih cepat)

3.'port_scanner_v1.py'
- Validasi input rentang port
- Tampilkan hasil scan ke terminal & penyimpanan file
- Penghitungan waktu scanning
- Handling error ketika resolve IP Domain


## 🚀 Cara Pakai
```bash
git clone https://github.com/kamu/python-cyber-tools.git
cd python-cyber-tools/<nama-folder>
python <nama-script>.py
