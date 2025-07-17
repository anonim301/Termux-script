#!/bin/bash

#function
ping_sweep() {
	for i in $(seq 1 5) 
	do
	ip="192.168.1.$i"
	ping -c 2 -W 1 $ip > /dev/null
	if [ $? -eq 0 ]
	then
		echo "✅ONLINE"
	else
		echo "❌OFFLINE"
	fi
	done
}

scan_host() {
	read -p "Masukkan IP/domain yang akan discan:" host
	nmap -p 22,80,443 $host
}

info_sistem() {
	echo "====INFO SISTEM===="
	echo "OS     : $(uname -o)"
	echo "Kernel : $(uname -r) "
	echo "Uptime : $(uname -p)"
}

keluar_program() {
	echo "Keluar program... "
	exit 1
}

#menu interaktif
while true
do
echo "1.Ping sweep! "
echo "2.Scan host! "
echo "3.Info sistem! "
echo "4.Keluar"

read -p "Pilih menu (1/2/3/4):" menu
case $menu in
	1)
		echo "Ping Sweep..."
		ping_sweep
		;;
	2) 
		echo "scan host... "
		scan_host
		;;
	3) 
		echo "info sistem... "
		sleep 2
		info_sistem
		;;
	4)
		echo "Keluar program"
		sleep 2
		keluar_program
		;;
	*)
		echo "Tidak ada diprogram! "
		;;
esac
done
echo ""
