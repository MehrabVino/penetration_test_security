#!/usr/bin/env python3
# onvif_test.py
from onvif import ONVIFCamera

def test_onvif_access(ip, port=80, user='admin', password='admin'):
    try:
        cam = ONVIFCamera(ip, port, user, password)
        
        # Get device information
        device_info = cam.devicemgmt.GetDeviceInformation()
        print(f"[+] ONVIF Device Found:")
        print(f"    Manufacturer: {device_info.Manufacturer}")
        print(f"    Model: {device_info.Model}")
        print(f"    Firmware: {device_info.FirmwareVersion}")
        
        # Get profiles and RTSP URLs
        media_service = cam.create_media_service()
        profiles = media_service.GetProfiles()
        
        for profile in profiles:
            stream_uri = media_service.GetStreamUri({
                'StreamSetup': {
                    'Stream': 'RTP-Unicast',
                    'Transport': {'Protocol': 'RTSP'}
                },
                'ProfileToken': profile.token
            })
            print(f"[+] RTSP URL: {stream_uri.Uri}")
            
        return True
    except Exception as e:
        print(f"[-] ONVIF Error: {e}")
        return False