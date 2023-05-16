#!/bin/bash

# Date: 14 May 2023
# Author: Joydeep Pal
# Description: This script sends those custom packets with space for metadata.
# Then receives packets at receiver and transfers it to source PC for analysis.
# Then converts pcap to raw hexdump in the form of json using tshark,
# then convert json to csv (one line for each packet)
# Specifically, this script sends and receives at the same interface, same PC. 
# So we filter out only the received packets (identified by vlan.id=5, this modification is done by the switch's c_packetprocessing function.

PacketCount=3600
pps=1
duration=$((PacketCount/pps))

tshark -i enp1s0f0 -w /tmp/metadata.pcap -a duration:$((duration+5)) &

echo ' '
echo 'Transmitting packets'
echo ' '
sleep 2
tcpreplay -i enp1s0f0 -L $PacketCount --pps $pps \
pcap/Traffic_Flow_vlan\(2\)_packetsize\(1000B\)_Priority\(0\)_NoPrio_metadata_test11.pcap

ls -al /tmp/*.pcap

echo ' '
echo 'Analyzing packets ...'
sleep 1
Date=$(date "+%Y%m%d-%H")
mv /tmp/metadata.pcap ./pcap/Test_2switch_MEts_sync_$Date.pcap

echo 'Packet Count:'
tshark -r pcap/Test_2switch_MEts_sync_$Date.pcap -Y "frame.len == 1000 and vlan.id == 5" | wc -l
echo ' '
tshark -r pcap/Test_2switch_MEts_sync_$Date.pcap -Y "frame.len == 1000 and vlan.id == 5" \
-T jsonraw | jq -c '.[]._source.layers.frame_raw' > pcap/sample_json_text_from_pcap_v2.csv

echo 'Packet Count:'
tshark -r pcap/Test_2switch_MEts_sync_$Date.pcap -Y "frame.len == 1000 and vlan.id == 5" | wc -l
echo ' '
tshark -r pcap/Test_2switch_MEts_sync_$Date.pcap -Y "frame.len == 1000 and vlan.id == 5" \
-T jsonraw | jq -c '.[]._source.layers.frame_raw' > pcap/sample_json_text_from_pcap_v2.csv

exit

<< comment
# For executing above 2 commands on a specific file

echo 'Packet Count:'
tshark -r pcap/Test_2switch_MEts_sync_20230514-14.pcap -Y "frame.len == 1000 and vlan.id == 5" | wc -l
echo ' '
shark -r pcap/Test_2switch_MEts_sync_20230514-14.pcap -Y "frame.len == 1000 and vlan.id == 5" \
-T jsonraw | jq -c '.[]._source.layers.frame_raw' > pcap/sample_json_text_from_pcap_v2.csv
comment

