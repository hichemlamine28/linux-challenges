#!/bin/bash

mkdir -p /opt/appdata/hidden
mkdir -p /opt/appdata/files
# Hidden files
find /home/bob/preserved -type f -name ".*" -exec cp "{}" /opt/appdata/hidden/ \;
# non-hidden files
find /home/bob/preserved -type f -not -name ".*" -exec cp "{}" /opt/appdata/files/ \;
# delete files with words ending in 't'
rm -f $(find /opt/appdata/ -type f  -exec grep -l 't\>' "{}"  \; )

# Replace: # Change all the occurrences of the word "yes" to "no"
find /opt/appdata -type f -name "*" -exec sed -i 's/\byes\b/no/g' "{}" \;
# Change all the occurrences of the word "raw" to "processed"
find /opt/appdata -type f -name "*" -exec sed -i 's/\braw\b/processed/ig' "{}" \;

# appdata.tar.gz # Create a "tar.gz" archive of "/opt/appdata" directory and save the archive to this file: "/opt/appdata.tar.gz"
cd /opt
tar -zcf appdata.tar.gz appdata

# Permissions # Sticky bit
chmod +t /opt/appdata
# Make bob owner
chown bob:bob /opt/appdata.tar.gz
# Set read-only
chmod 440 /opt/appdata.tar.gz

# Softlink
ln -s /opt/appdata.tar.gz /home/bob/appdata.tar.gz

# Filter.sh 
cat <<'EOF' > /home/bob/filter.sh
#!/bin/bash
tar -xzOf /opt/appdata.tar.gz | grep processed > /home/bob/filtered.txt
EOF
chmod +x /home/bob/filter.sh

# Filtered.txt # Execute our script
/home/bob/filter.sh
