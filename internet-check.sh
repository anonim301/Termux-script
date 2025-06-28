#! /bin/bash
log_file="internet_log.txt"
ping -c 3 google. com > /dev/null 2>&1
if [ $? -eq 0 ] ;  then
    echo "$(date) : ✅ internet aktif" >> $log_file
else
    echo "$(date) : ❎ internet offline" >> $log_file
fi
echo "Log disimpan di $log_file"
