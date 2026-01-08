# Drone WiFi networks often have specific SSID patterns
# Common patterns: DJI_*, Parrot_*, Bebop_*, Phantom_*, Autel_*

# Use airodump-ng to find drone networks
sudo airodump-ng wlan0mon

# Scan for drone services
nmap -sV -p 21,23,80,443,554,8888,8080,6038,14550,14551 192.168.1.100

# Common drone ports:
# 21 - FTP (firmware updates)
# 23 - Telnet (debug access)
# 80/443 - Web interface
# 554 - RTSP (video stream)
# 8888/8080 - Video streaming
# 6038 - DJI video port
# 14550/14551 - MAVLink protocol