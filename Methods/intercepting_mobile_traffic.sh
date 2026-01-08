# Setup proxy on mobile device
# Android:
adb shell settings put global http_proxy 192.168.1.100:8080

# iOS: Manual proxy setup in WiFi settings

# Capture all traffic
tcpdump -i any -s 0 -w mobile_capture.pcap

# Monitor specific apps
frida-trace -U -i "recv*" -i "send*" com.target.app