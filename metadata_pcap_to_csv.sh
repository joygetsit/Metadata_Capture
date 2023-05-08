#!/bin/bash

# Date - 07 May 2023
# Author - Joydeep Pal
# Description - Converts pcap to raw hexdump in the form of json using tshark, then convert json to csv (one line for each packet)

echo 'Packet Count:'
tshark -r pcap/metadata_2switch_MEts.pcap -Y "frame.len == 1000" | wc -l
echo ' '
tshark -r pcap/metadata_2switch_MEts.pcap -Y "frame.len == 1000" -T jsonraw | jq -c '.[]._source.layers.frame_raw' > pcap/sample_json_text_from_pcap.csv
