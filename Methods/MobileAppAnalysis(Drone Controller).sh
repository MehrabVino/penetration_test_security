# Extract drone controller app
# Android:
apktool d dji.go.apk -o dji_decoded

# Look for:
grep -r "password\|token\|key\|secret" dji_decoded/
grep -r "api.*\.dji\.com" dji_decoded/

# Common findings:
# - API keys for cloud services
# - Firmware update URLs
# - Telemetry endpoints
# - Flight restriction bypass methods

# Analyze network traffic
# Setup MITM between controller app and drone/cloud