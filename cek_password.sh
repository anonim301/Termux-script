#!/bin/bash
read -p "Masukkan password:" pass

if [ "$pass" == "123456" ]; then
    echo "Akses diberikan! "
else
    echo "Akses diblock! "
fi

