# Some of our apps generate some raw data and store the same in /home/bob/preserved directory. We want to clean and manipulate some data and then want to create an archive of that data.
# Note: The validation will verify the final processed data so some of the tests might fail till all data is processed as asked.

# All the tasks require you to be root, so the first step is to become root
sudo -i

## Individual Steps ##
# Find # Find the "hidden" files in "/home/bob/preserved" directory and copy them in "/opt/appdata/hidden/" directory (create the destination directory if doesn't exist).
mkdir -p /opt/appdata/hidden
find /home/bob/preserved -type f -name ".*" -exec cp "{}" /opt/appdata/hidden/ \;

# Find the "non-hidden" files in "/home/bob/preserved" directory and copy them in "/opt/appdata/files/" directory (create the destination directory if doesn't exist).
mkdir -p /opt/appdata/files
find /home/bob/preserved -type f -not -name ".*" -exec cp "{}" /opt/appdata/files/ \;

# Find and delete the files in "/opt/appdata" directory that contain a word ending with the letter "t" (case sensitive).
rm -f $(find /opt/appdata/ -type f -exec grep -l 't\>' "{}"  \; )

# Replace # Change all the occurrences of the word "yes" to "no" in all files present under "/opt/appdata/" directory.
find /opt/appdata -type f -name "*" -exec sed -i 's/\byes\b/no/g' "{}" \;

# Change all the occurrences of the word "raw" to "processed" in all files present under "/opt/appdata/" directory. It must be a "case-insensitive" replacement, means all words must be replaced like "raw , Raw , RAW" etc.
find /opt/appdata -type f -name "*" -exec sed -i 's/\braw\b/processed/ig' "{}" \;

# appdata.tar.gz # Create a "tar.gz" archive of "/opt/appdata" directory and save the archive to this file: "/opt/appdata.tar.gz"
cd /opt
# /opt/appdata contains the final processed data
tar -zcf appdata.tar.gz appdata

# Permissions #Add the "sticky bit" special permission on "/opt/appdata" directory (keep the other permissions as it is).
chmod +t /opt/appdata

# Make "bob" the "user" and the "group" owner of "/opt/appdata.tar.gz" file.
chown bob:bob /opt/appdata.tar.gz

# The "user/group" owner should have "read only" permissions on "/opt/appdata.tar.gz" file and "others" should not have any permissions.
chmod 440 /opt/appdata.tar.gz
# or # chmod u=r,g=r,o= /opt/appdata.tar.gz

# Softlink # Create a "softlink" called "/home/bob/appdata.tar.gz" of "/opt/appdata.tar.gz" file.

ln -s /opt/appdata.tar.gz /home/bob/appdata.tar.gz

# filter.sh and filtered.txt # Create a script called "/home/bob/filter.sh".
# The script should filter the lines from "/opt/appdata.tar.gz" file which contain the word "processed", and save the filtered output in "/home/bob/filtered.txt" file. It must "overwrite" the existing contents of "/home/bob/filtered.txt" file.
vi /home/bob/filter.sh

# Add the following lines and save it.
#!/bin/bash
tar -xzOf /opt/appdata.tar.gz | grep processed > /home/bob/filtered.txt

# Make executable, and run it
chmod +x /home/bob/filter.sh
/home/bob/filter.sh





##  Using script ##

# type :
sudo -i
vi challenge4.sh
# copy the script challenge4.sh into centos server of your lab and type escape +:wq  to save

# Add exection permission:
chmod +x challenge4.sh

# Run the script:
./challenge4.sh



# Do a check to Verify



# Enjoy


