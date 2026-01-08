# 1. iTunes Backup Analysis
# Enable encrypted backup in iTunes
# Extract backup data
# Location on macOS: ~/Library/Application Support/MobileSync/Backup/
# Use tools like iPhone Backup Analyzer, iBackupBot

# 2. MITM with Certificate Pinning Bypass
# Install Burp/Charles certificate
# Use objection to bypass SSL pinning:
objection -g com.target.app explore
ios sslpinning disable

# 3. Runtime Analysis with Frida
frida -U -f com.target.app -l dump_credentials.js