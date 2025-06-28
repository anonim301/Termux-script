#!/bin/bash

echo "Masukkan sebuah angka:"
read angka

if [ $angka -lt 0 ]; then
  echo "Angka negatif"
elif [ $((angka % 2)) -eq 0 ]; then
  echo "Angka genap"
else
  echo "Angka ganjil"
fi


