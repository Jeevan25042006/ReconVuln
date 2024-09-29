#!/bin/bash

# Check if the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "Please run as root."
   exit 1
fi

# Clean up temporary files if the script is interrupted
trap "rm -f hosts.txt scan.xml; exit" INT TERM

# Get the IP address of the current machine
ip=$(hostname -I | awk '{print $1}')
echo "Your IP address is: $ip"

# Scan the local network for live hosts
echo "Finding live hosts in the network..."
sudo nmap -sn "$ip"/24 -oN hosts.txt > /dev/null

# Extract live hosts from the scan result
declare -a hostsup=($(grep "Nmap scan report for" hosts.txt | awk '{print $5}'))

if [ ${#hostsup[@]} -eq 0 ]; then
    echo "No live hosts found."
    exit 1
fi

# Display the live hosts
echo "Live hosts found:"
for i in "${hostsup[@]}"; do
    echo "- $i"
done

# Perform detailed scanning and vulnerability checking on each live host
echo "Starting detailed scans on live hosts..."
for i in "${hostsup[@]}"; do
    echo -e "\nScanning Host: $i"
    nmap -sS -A "$i" -oX scan.xml > /dev/null 2>&1
    grep "<port " scan.xml | awk -F'"' '{print "Port:", $4, "- Service:", $8}'
    searchsploit --nmap scan.xml
    rm -f scan.xml
done

# Cleanup temporary files
rm -f hosts.txt
