# Check if USB debugging enabled
adb devices

# Extract SMS without root
adb shell content query --uri content://sms/inbox --projection address,body,date

# Extract call log
adb shell content query --uri content://call_log/calls

# Pull photos
adb pull /sdcard/DCIM/Camera/ ./photos/

# Create full backup
adb backup -apk -shared -all -system -f full_backup.ab

# Install Frida server on device
adb push frida-server /data/local/tmp/
adb shell "chmod 755 /data/local/tmp/frida-server"
adb shell "/data/local/tmp/frida-server &"

# Dump app memory
frida -U -f com.target.app -l dump_memory.js