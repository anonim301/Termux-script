#!/bin/bash

echo "🛠Port scanner sederhana"
read -p "Masukkan target IP/Domain:" target
read -p "Masukkan port awal:" start
read -p "Masukkan port akhir:" end

echo "Scanning $target dari port $start sampai $end...."

for ((port=$start; port<=$end; port++)) 
do
	timeout 1 bash -c "echo > /dev/tcp/$target/$port" 2>/dev/null && \
		echo "✅Port $port TERBUKA" ||\
		echo "❌Port $port TERTUTUP"
done


