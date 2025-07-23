import os

#list kumpulan target
target_list = ["google.com", "github.com", "facebook.com"]

for target in target_list:
	print(f"Memeriksa: {target}")
	response = os.system(f"ping -c 1 {target}")
	
	if response == 0:
		print(f"{target} ONLINE!!....")
	else:
		print(f"{target} OFFLINE!!...")
