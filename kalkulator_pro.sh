#!/bin/bash

help() {
    echo "Cara pakai: bash kalkulator_pro.sh <angka1> <operator> <angka2>"
    echo "Contoh   : bash kalkulator_pro.sh 5 + 7"
    echo "Operator  : +  -  x  /  %  ^  sqrt"
}

if [ $# -lt 2 ]; then
    help
    exit 1
fi

angka1=$1
operator=$2
angka2=$3

case $operator in
    +) hasil=$(echo "$angka1 + $angka2" | bc);;
    -) hasil=$(echo "$angka1 - $angka2" | bc);;
    x) hasil=$(echo "$angka1 * $angka2" | bc);;
    /) hasil=$(echo "scale=4; $angka1 / $angka2" | bc);;
    %) hasil=$(echo "$angka1 * $angka2 / 100" | bc);;
    ^) hasil=$(echo "$angka1 ^ $angka2" | bc);;
    sqrt) hasil=$(echo "scale=4; sqrt($angka1)" | bc);;
    *) echo "Operator tidak dikenali"; exit 1;;
esac

echo "Hasil: $hasil"
