#!/bin/bash

# Date: 3rd May 2023
# Author: Joydeep Pal
# Description: This script sends those custom packets with space for metadata.

tcpreplay -i enp1s0f0 -L 120 --pps 1 pcap/Traffic_Flow_vlan\(2\)_packetsize\(1000B\)_Priority\(0\)_NoPrio_metadata_test11.pcap

