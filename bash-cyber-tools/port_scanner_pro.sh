#!/bin/bash
#script port scanner powerfull
#usage:
#./port_scanner_pro.sh <host_or_file> [star_port] [end_port] [max_threads]
#example: ./port_scanner_pro.sh 192.168.1.10 1 1024 50
#example: ./port_scanner_pro.sh host.txt 20 1024 50

host=$1
start_port=${2:-1}
end_port=${3:-1024}
max_threads=${4:-50}
output_dir="scan_results"
mkdir -p $output_dir

scan_port() {
	local host=$1
	local port=$2
	timeout 1 bash -c  "echo >/dev/tcp/$host/$port" &> /dev/null
	if [[ $? -eq 0 ]]
	then
		echo "$host, $port OPEN" | tee -a "$output_dir/scan_$host.csv"
	fi
}

#Fungsi scan host
scan_host() {
	local host=$1
	local output_file="$outout_dir/scan_$host.csv"
	
	echo "Mulai scan $host dari $start_port sampai $end_port"
	echo "Host, Port, Status" >> "$output_dir/scan_$host.csv"	 count=0
	for ((port=start_port; port<=end_port; port++))
	do
		scan_port $host $port & ((count++)) 
		if ((count >= max_threads)) 
		then
			wait
			count=0
		fi
	done
	wait
	echo "Scan $host selesai hasil disimpan di $output_dir/scan_$host.csv"
}

if [[ -f $host ]] 
then
	while read -r line
	do
		scan_host $host
	done < $host
else
	scan_host $host
fi


		
