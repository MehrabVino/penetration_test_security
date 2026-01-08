#!/usr/bin/env python3
# drone_command.py
from pymavlink import mavutil

def send_drone_command(target_ip='192.168.1.100', target_port=14550):
    """Send commands to drone via MAVLink"""
    
    # Create connection
    connection = mavutil.mavlink_connection(f'udp:{target_ip}:{target_port}')
    
    # Send heartbeat (identify as ground station)
    connection.mav.heartbeat_send(
        mavutil.mavlink.MAV_TYPE_GCS,
        mavutil.mavlink.MAV_AUTOPILOT_INVALID,
        0, 0, 0
    )
    
    print("[*] Connected to drone")
    
    # Example: Request telemetry
    connection.mav.request_data_stream_send(
        target_system=1,
        target_component=1,
        req_stream_id=0,
        req_message_rate=10,  # 10 Hz
        start_stop=1  # Start stream
    )
    
    # Example: Send waypoint (navigation command)
    # WARNING: This will make drone move!
    """
    connection.mav.mission_item_send(
        target_system=1,
        target_component=1,
        seq=0,
        frame=mavutil.mavlink.MAV_FRAME_GLOBAL_RELATIVE_ALT,
        command=mavutil.mavlink.MAV_CMD_NAV_WAYPOINT,
        current=0,
        autocontinue=0,
        param1=0,  # Hold time
        param2=0,  # Acceptance radius
        param3=0,  # Pass radius
        param4=0,  # Yaw angle
        x=37.7749,  # Latitude
        y=-122.4194,  # Longitude
        z=100  # Altitude (meters)
    )
    """