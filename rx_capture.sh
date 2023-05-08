#!/bin/bash

# Date: 08 May 2023
# Author: Joydeep Pal
# Description: This script receives packets at receiver and transfers it to source PC for ananlysis.

ssh zenlab@10.114.64.248 "
tshark -i enp1s0f0 -w /tmp/metadata.pcap  -a duration:125
ll /tmp/*.pcap
sleep 2
"

scp zenlab@10.114.64.248:/tmp/metadata.pcap ./pcap/Test_2switch_MEts_$(date).pcap

