# Extract firmware
binwalk -e camera_firmware.bin

# Look for sensitive files in extracted filesystem
find . -type f \( -name "*.db" -o -name "*.sqlite" -o -name "*.jpg" -o -name "*.mp4" \)
grep -r "password\|admin\|root\|key\|token" ./
find . -name "shadow" -exec cat {} \;
find . -name "passwd" -exec cat {} \;

# Look for web interface files
find . -name "*.php" -o -name "*.cgi" -o -name "*.js" | xargs grep -l "gallery\|video\|stream"