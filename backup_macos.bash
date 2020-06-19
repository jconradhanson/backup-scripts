#!/bin/bash
IP_ADDRESS="xxx.xxx.xx.xxx"
MAC_ADDRESS="xx:xx:xx:xx:xx:xx"
PORT=9

echo "Waking up FreeNAS for Time Machine Backup"
magic_packet_script="
import socket

mac_addr = ''.join('$MAC_ADDRESS'.split(':'))
magic_packet = bytes.fromhex('F' * 12 + mac_addr * 16)

with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as udp_connection:
    udp_connection.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
    print(udp_connection.sendto(magic_packet, ('255.255.255.255', $PORT)))
"

# send the magic packet over UDP to MAC address of FreeNAS
python3 -qc "$magic_packet_script"

printf "Waiting for Time Machine to be ready\n"
status=$(ping -oq -t 300 "$IP_ADDRESS" | grep "1 packets received")

if [ -z "$status" ]; then
echo "FreeNAS didn't wake in 5 minutes of waiting."
return
fi

printf "Starting Time Machine Backup\n"
# tmutil startbackup --block 
ssh -t root@$IP_ADDRESS "shutdown -p now"
