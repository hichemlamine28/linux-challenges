# Some new developers have joined our team, so we need to create some users/groups and further need to setup some permissions and access rights for them.
# All the tasks require you to be root, so the first step is to become root

sudo -i

# Individual Steps
# admins # Create a group called "admins".
groupadd admins

# David # Create a user called "david" , change his login shell to "/bin/zsh".
useradd -s /bin/zsh david

# Set "D3vUd3raaw" password for this user.
passwd david

# Enter the given password and confirm it.
# Make user "david" a member of "admins" group.
usermod -G admins david

# Natasha # Create a user called "natasha" , change her login shell to "/bin/zsh".
useradd -s /bin/zsh natasha

# Set "DwfawUd113" password for this user.
passwd natasha

# Enter the given password and confirm it.
# Make user "natasha" a member of "admins" group.
usermod -G admins natasha

# devs # Create a group called "devs".
groupadd devs

# Ray # Create a user called "ray" , change his login shell to "/bin/sh".
useradd -s /bin/sh ray

# Set "D3vU3r321" password for this user.
passwd ray

# Enter the given password and confirm it.
# Make user "ray" a member of "devs" group.
usermod -G devs ray

# Lisa # Create a user called "lisa" , change her login shell to "/bin/sh".
useradd -s /bin/sh lisa

# Set "D3vUd3r123" password for this user.
passwd lisa

# Enter the given password and confirm it.
# Make user "lisa" a member of "devs" group.
usermod -G devs lisa

# Bob, data
# These two tasks are really one...
# Make sure "/data" directory is owned by user "bob" and group "devs"...
chown bob:devs /data

# ...and group "devs" and "user/group" owner has "full" permissions but "other" should not have any permissions.
chmod 770 /data

# access control
# Give some additional permissions to "admins" group on "/data" directory so that any user who is the member the "admins" group has "full permissions" on this directory.
setfacl -m g:admins:rwx /data

[# Manual page](https://linux.die.net/man/1/setfacl)
# sudo # Make sure all users under "admins" group can run all commands with "sudo" and without entering any password.
visudo

# Enter the following line at the end of the file and save
%admins ALL=(ALL) NOPASSWD:ALL

# sudo(dnf) # Make sure all users under "devs" group can only run the "dnf" command with "sudo" and without entering any password.
visudo

# Enter the following line at the end of the file and save
%devs ALL=(ALL) NOPASSWD:/usr/bin/dnf

# limits # Configure a "resource limit" for the "devs" group so that this group (members of the group) can not run more than "30 processes" in their session. This should be both a "hard limit" and a "soft limit", written in a single line.
vi /etc/security/limits.conf

# Enter the following line at the end of the file and save
@devs            -       nproc           30

# quota # Edit the disk quota for the group called "devs". Limit the amount of storage space it can use (not inodes). 
# Set a "soft" limit of "100MB" and a "hard" limit of "500MB" on "/data" partition.

# First, determine the device path for /data
mount | grep '/data'

# Then set the quota on the device
setquota -g devs 100M 500M 0 0 /dev/vdb1

[Manual page](https://linux.die.net/man/8/setquota) - First form of the command. Inode limits are set to zero, meaning unlimited.





##  Using script ##

# type :
sudo -i
vi challenge3.sh
# copy the script challenge3.sh into centos server of your lab and type escape +:wq  to save

# Add exection permission:
chmod +x challenge3.sh

# Run the script:
./challenge3.sh



# Do a check to Verify



# Enjoy
