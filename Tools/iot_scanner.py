#!/usr/bin/env python3
# iot_scanner.py
import nmap
import requests

def scan_network(network):
    nm = nmap.PortScanner()
    nm.scan(hosts=network, arguments='-sV')
    
    for host in nm.all_hosts():
        print(f"\n[+] Host: {host}")
        print(f"    State: {nm[host].state()}")
        
        for proto in nm[host].all_protocols():
            ports = nm[host][proto].keys()
            for port in ports:
                service = nm[host][proto][port]
                print(f"    Port: {port}/{proto} - {service['name']} - {service['product']} {service['version']}")
                
                # Check for web services
                if service['name'] in ['http', 'https', 'http-alt']:
                    test_web_interface(host, port)

def test_web_interface(host, port):
    urls = [
        f"http://{host}:{port}/",
        f"http://{host}:{port}/login",
        f"http://{host}:{port}/admin",
        f"http://{host}:{port}/config"
    ]
    
    for url in urls:
        try:
            r = requests.get(url, timeout=2)
            print(f"        Web: {url} - Status: {r.status_code}")
            if 'admin' in r.text.lower():
                print(f"        [*] Admin interface found!")
        except:
            pass

if __name__ == "__main__":
    scan_network("192.168.1.0/24")