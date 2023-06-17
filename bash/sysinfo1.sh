#!/bin/bash


# echo command to print blank link
echo


# Getting hostname
name=$(hostname)
echo Report for $name


# Seperator
echo ===============================


# Command to fetch fully-qualified domain name
fqdn=$(hostname -f)
echo FQDN: $fqdn


# Command to fetch Operating System name and version
os_name_version=$(hostnamectl | awk '/Operating System:/{print $3, $4, $5}')
echo Operating System name and version: $os_name_version


# Command to fetch IP address
ip_address=$(hostname -I)
echo IP Address: $ip_address


# Command to fetch free space
space=$(df -h / | grep dev | awk '{print $4}')
echo Root Filesystem Free Space: $space


# Seperator
echo ===============================


# echo command to print blank link
echo
