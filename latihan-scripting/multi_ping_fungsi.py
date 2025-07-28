import os

#variabel
target_list = ["google.com","facebook.com","github.com"]

#fungsi ping website
def ping_website(website):
	print(f"\nMemeriksa: {website}")
	response = os.system(f"ping -c 1 {website}")
	if response == 0:
		print(f"ONLINE: {website}")
	else:
		print(f"OFFLINE: {website}")

#ping semua target dan panggil fungsi
for site in target_list:
	ping_website(site)
	
