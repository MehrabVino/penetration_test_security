# If device is rooted or you gain root access:
adb shell
su
# Now you have full access

# Extract complete data partition
dd if=/dev/block/bootdevice/by-name/userdata of=/sdcard/userdata.img

# Access protected app directories
cp -r /data/data/com.android.providers.telephony /sdcard/telephony_data
cp /data/data/com.android.providers.telephony/databases/mmssms.db /sdcard/