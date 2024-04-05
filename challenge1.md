The database server called centos-host is running short on space! You have been asked to add an LVM volume for the Database team using some of the existing disks on this server.
All the tasks require you to be root, so the first step is to become root

sudo -i

## Individual Steps ##
Linux Server: 
Install the correct packages that will allow the use of "lvm" on the centos machine. First we need to discover what the correct package is that needs to be installed. A google search will lead you to lvm2:

# Install package:
sudo yum install -y lvm2

# dba_users: Create a group called "dba_users" and add the user called 'bob' to this group:
groupadd dba_users

# Add bob to group:
usermod -G dba_users bob

# /dev/vdb: Create a Physical Volume for "/dev/vdb":
pvcreate /dev/vdb

# /dev/vdc: Create a Physical Volume for "/dev/vdc":
pvcreate /dev/vdc

# volume-group: Create a volume group called "dba_storage" using the physical volumes "/dev/vdb" and "/dev/vdc":
vgcreate dba_storage /dev/vdb /dev/vdc

# lvm: Create an "lvm" called "volume_1" from the volume group called "dba_storage". Make use of the entire space available in the volume group.:
lvcreate -n volume_1 -l 100%FREE dba_storage

# persistent-mountpoint: Format the lvm volume "volume_1" as an "XFS" filesystem
mkfs.xfs /dev/dba_storage/volume_1

# Mount the filesystem at the path "/mnt/dba_storage".:
mkdir -p /mnt/dba_storage
mount -t xfs /dev/dba_storage/volume_1 /mnt/dba_storage

# Make sure that this mount point is persistent across reboots with the correct default options.:
vi /etc/fstab

# Add the following line to the end of the file and save:
/dev/mapper/dba_storage-volume_1 /mnt/dba_storage xfs defaults 0 0

# group-permission: Ensure that the mountpoint "/mnt/dba_storage" has the group ownership set to the "dba_users" group:
chown :dba_users /mnt/dba_storage

# Ensure that the mount point "/mnt/dba_storage" has "read/write" and execute permissions for the owner and group and no permissions for anyone else.:
chmod 770 /mnt/dba_storage




## Using script ##

# type :
sudo -i
vi challenge1.sh
# copy the script challenge1.sh into centos server of your lab and type escape +:wq  to save

# Add exection permission:
chmod +x challenge1.sh

# Run the script:
./challenge1.sh



# Do a check to Verify



# Enjoy

