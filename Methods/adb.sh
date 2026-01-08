# Check if device is connected and debugging enabled
adb devices
adb shell

# Basic enumeration
adb shell getprop ro.product.model
adb shell getprop ro.build.version.sdk
adb shell pm list packages

# Data Extraction Methods
# ------------------------

# 1. Gallery/Photos Extraction
adb pull /sdcard/DCIM/Camera/ ./mobile_photos/
adb pull /sdcard/Pictures/ ./mobile_pictures/
adb shell ls -la /data/media/0/DCIM/  # Android 10+

# 2. SMS/Message Extraction
# Method A: Via content provider (no root needed on some devices)
adb shell content query --uri content://sms/inbox --projection address,body,date

# Method B: Backup extraction
adb backup -noapk com.android.providers.telephony -f sms_backup.ab
# Convert backup file
dd if=sms_backup.ab bs=1 skip=24 | python3 -c "import zlib,sys;sys.stdout.buffer.write(zlib.decompress(sys.stdin.buffer.read()))" > sms_backup.tar
tar -xf sms_backup.tar

# 3. Call Log Extraction
adb shell content query --uri content://call_log/calls --projection number,name,duration,date

# 4. File System Dump
adb pull /sdcard/ ./full_sdcard_dump/
adb pull /data/data/ ./app_data_dump/  # Requires root

# 5. App Data Extraction
# List all apps and their data directories
adb shell pm list packages -f
# Example: Extract WhatsApp data (if backup allowed)
adb backup -noapk com.whatsapp -f whatsapp_backup.ab