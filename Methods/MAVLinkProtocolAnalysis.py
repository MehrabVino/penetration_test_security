#!/usr/bin/env python3
# mavlink_sniffer.py
import socket
from pymavlink import mavutil

def sniff_mavlink(interface_ip='0.0.0.0', port=14550):
    """Capture and analyze MAVLink packets"""
    
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.bind((interface_ip, port))
    
    print(f"[*] Listening for MAVLink on port {port}")
    
    while True:
        data, addr = sock.recvfrom(1024)
        print(f"\n[+] Packet from {addr}")
        print(f"    Raw: {data.hex()[:50]}...")
        
        try:
            # Parse MAVLink message
            msg = mavutil.mavlink.parse(data)
            if msg:
                msg_type = msg.get_type()
                print(f"    Message Type: {msg_type}")
                
                # Extract interesting data
                if msg_type == 'GPS_RAW_INT':
                    lat = msg.lat / 1e7
                    lon = msg.lon / 1e7
                    alt = msg.alt / 1000
                    print(f"    GPS: Lat={lat}, Lon={lon}, Alt={alt}m")
                    
                elif msg_type == 'HEARTBEAT':
                    print(f"    System Status: {msg.system_status}")
                    print(f"    Base Mode: {msg.base_mode}")
                    
                elif msg_type == 'SYS_STATUS':
                    print(f"    Battery: {msg.voltage_battery/1000}V")
                    print(f"    Battery %: {msg.battery_remaining}%")
                    
                elif msg_type == 'ATTITUDE':
                    print(f"    Roll: {msg.roll}, Pitch: {msg.pitch}, Yaw: {msg.yaw}")
                    
        except Exception as e:
            print(f"    Parse Error: {e}")