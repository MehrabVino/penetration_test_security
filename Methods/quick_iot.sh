# Find RTSP cameras
nmap -p 554,8554 --open 192.168.1.0/24

# Test default credentials
hydra -L users.txt -P passwords.txt 192.168.1.100 http-get /

# Capture firmware via UART
screen /dev/ttyUSB0 115200
# During boot, interrupt and:
cat /proc/mtd
cat /dev/mtd2 > /tmp/firmware.bin

# Analyze firmware
binwalk -e firmware.bin
strings firmware.bin | grep -i "password\|admin\|root"

# Sniff Zigbee traffic
sudo zbdump -c 11 -w zigbee.pcap

# Test MQTT
mosquitto_sub -h 192.168.1.100 -t "#" -v
mosquitto_pub -h 192.168.1.100 -t "test" -m "hello"