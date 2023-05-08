# Date - 08 May 2023
# Description - This folder consists of files for creating packets, transmit from source, save packet capture as pcap manually at receiver, convert pcap to csv, analyse csv.

- 'pcap' and 'csv' files are stored in '/pcap' folder

## Generate packets with custom Metadata Header
Generate 65536 packets with a Metadata Header of 40 Bytes (5 fields of 8 bytes) with distinct default values
	- generate_metadata.py
Created [07 May 2023]
	- Traffic_Flow_vlan(2)_packetsize(500B)_Priority(0)_NoPrio_metadata_test11.pcap
	- Traffic_Flow_vlan(2)_packetsize(1000B)_Priority(0)_NoPrio_metadata_test11.pcap

Generate 5 packets with a Metadata Header of 40 Bytes (5 fields of 8 bytes) with distinct default values for testing reading pcap files, filtering and extracting information
	- generate_metadata.py with 5 packets
Created [07 May 2023]
	- Traffic_Flow_vlan(2)_packetsize(1000B)_Priority(0)_NoPrio_metadata_test10.pcap
	- Traffic_Flow_vlan(2)_packetsize(500B)_Priority(0)_NoPrio_metadata_test10.pcap

## Transmit at a specified rate for a particular duration or packet count
Transmit pcap files from source
	- [07 May 2023] send_packets_with_metadataheader.sh

Packet Processing done in NFP, adds timestamps in Metadata Header.

Packets received in Receiver (UR3) after being handled by TSN switch 1 and 2
	- [05 May 2023] Test1_2switch_MEts_filtered.pcap
	- [07 May 2023] Test2_2switch_MEts.pcap

## Convert pcap to csvand store in '/pcap' folder
	- metadata_pcap_to_csv.sh
	- [05 May 2023] sample_json_text_from_pcap.csv
	
## Analyse csv to extracted Metadata Header and plot synchronisation error in plots/test(n)_sync_error
	- analyse_metadata_pcap.py
## Without sync
	- [05 May 2023] Test2_sync_error -  1hr 10pps, falls 24ms over 1hr
	- [07 May 2023] Test2_sync_error - 3hrs 01pps, falls 60ms over 3hrs
## With sync

