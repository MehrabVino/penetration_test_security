# Using KillerBee for Zigbee
sudo zbassocflood -c 11 -a AA:BB:CC:DD:EE:FF
sudo zborphannotify -c 11 -s AA:BB:CC:DD:EE:FF -d AA:BB:CC:DD:EE:00

# Capture packets
sudo zbdump -c 11 -w capture.pcap

# Analyze with Wireshark
wireshark -X lua_script:/usr/share/killerbee/zigbee.lua capture.pcap