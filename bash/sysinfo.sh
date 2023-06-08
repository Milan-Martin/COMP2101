#!/bin/bash


# Finding fully-qualified domain name by using hostname command
fqdn=$(hostname -f)
echo FQDN: $fqdn


# Getting Operating System name and version by using hostnamectl and awk command
os_name_version=$(hostnamectl | awk '/Operating System:/{print $3, $4, $5}')
echo Operating System name and version: $os_name_version


# Fetching all ip address except loop back
ip_address=$(hostname -I)
echo IP Addresses: $ip_address 


# Getting File Status in human understandable size
echo Root Filesystem Status:
temp=$(df | awk '{print $1, $2, $3, $4, $5, $6}' | head -1)
result=$(df -H | awk '{print $1, $2, $3, $4, $5, $6}' | grep '/dev/sda1')
echo $temp
echo $result
