#!/bin/bash


# echo command to print title
echo Title : System Description

vendor=$(sudo lshw | grep vendor | head -n 1 | awk '/vendor:/{print $2, $3}')
description=$(sudo lshw | grep description | head -n 1 | awk '/description:/{print $2}')
serial=$(sudo lshw | grep serial | head -n 1 | awk '/serial:/{print $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16}')

echo Computer manufacturer: $vendor
echo Computer description or model: $description
echo Computer serial number: $serial
echo ==============================
echo


# echo command to print title
echo Title : CPU Information

model_name=$(sudo lscpu | grep 'Model name' | awk '{print $3, $4, $5, $6, $7, $8}')
architecture=$(lscpu | grep 'Architecture' | awk '/Architecture:/{print $2}')
corePerSocket=$(lscpu | grep 'Core(s) per socket' | awk '{print $4}')
socket=$(lscpu | grep 'Socket(s)' | awk '{print $2}')
maxSpeed=$(lscpu | grep 'CPU MHz' | awk '{print $3}')
l1d=$(lscpu | grep 'L1d cache' | awk '{print $3}')
l1i=$(lscpu | grep 'L1i cache' | awk '{print $3}')
l2=$(lscpu | grep 'L2 cache' | awk '{print $3}')
l3=$(lscpu | grep 'L3 cache' | awk '{print $3}')

echo CPU manufacturer and model: $model_name
echo CPU architecture: $architecture
echo CPU core count: `expr $corePerSocket \* $socket`
echo CPU maximum speed in a human friendly format: $maxSpeed
echo Sizes of L1d caches: $l1d 'KB'
echo Sizes of L1d caches: $l1i 'KB'
echo Sizes of L1d caches: $l2 'MB'
echo Sizes of L1d caches: $l3 'MB'
echo ==============================
echo


# echo command to print title
echo Title : Operating System Information

linuxDistro=$(lsb_release -a | grep 'Distributor ID' | awk '{print $3}')
linuxRelease=$(lsb_release -a | grep 'Release' | awk '{print $2}')

echo Linux distro: $linuxDistro
echo Linux distro: $linuxRelease
echo ==============================
