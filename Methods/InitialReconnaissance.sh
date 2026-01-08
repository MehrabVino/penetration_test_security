# Scan for cameras
nmap -sV -p 80,443,554,8554,37777,37778 192.168.1.0/24

# Check for RTSP streams
nmap -p 554 --script rtsp-url-brute 192.168.1.100

# Common RTSP URLs to try:
rtsp://admin:admin@192.168.1.100:554/stream1
rtsp://192.168.1.100:554/11
rtsp://192.168.1.100:554/user=admin&password=&channel=1&stream=0.sdp
rtsp://192.168.1.100:554/ch0_0.h264
rtsp://192.168.1.100:554/onvif1