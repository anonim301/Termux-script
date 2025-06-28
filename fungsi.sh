#!/bin/bash

salam() {
  echo "Halo, selamat datang di Termux!"
}

tampil_nama() {
  echo "Masukkan nama kamu:"
  read nama
  echo "Halo, $nama!"
}

salam
tampil_nama
