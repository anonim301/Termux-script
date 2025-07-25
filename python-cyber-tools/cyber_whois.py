import whois

#input domain dari user
domain = input("Masukkan nama domain (contoh: google.com):") 
try:
	info = whois.whois(domain) 
	print("\n📝Informasi whois:") 
	print("-" * 30) 
	print(f"Name domain     : {info.domain_name}") 
	print(f"Tanggal dibuat  : {info.registrar}") 
	print(f"Expired         : {info.creation_date}") 
	print(f"Name server     : {info.name_servers}") 
	print(f"Email kontak    : {info.emails}") 
	print(f"Negara          : {info.country}") 
	print("-" * 30) 

except Exception as e:
	print(f"[!] Gagal mengambil informasi: {e}") 

