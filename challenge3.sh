#!/bin/bash

# admins # Create a group called "admins"
groupadd admins

# David # Create a user called "david" , change his login shell to "/bin/zsh"
useradd -s /bin/zsh david
# and set "D3vU3r321" password for this user
echo "D3vUd3raaw" | passwd --stdin david
# Make user "david" a member of "admins" group.
usermod -G admins david

# Natasha # Create a user called "natasha" , change her login shell to "/bin/zsh"
useradd -s /bin/zsh natasha
# and set "DwfawUd113" password for this user
echo "DwfawUd113" | passwd --stdin natasha
# Make user "natasha" a member of "admins" group.
usermod -G admins natasha


# devs # Create a group called "devs"
groupadd devs

# ray # Create a user called "ray" , change his login shell to "/bin/sh"
useradd -s /bin/sh ray
# and set "D3vU3r321" password for this user
echo "D3vU3r321" | passwd --stdin ray
# Make user "ray" a member of "devs" group.
usermod -G devs ray

# lisa # Create a user called "lisa" , change her login shell to "/bin/sh"
useradd -s /bin/sh lisa
# and set "D3vU3r321" password for this user
echo "D3vUd3r123" | passwd --stdin lisa
# Make user "lisa" a member of "devs" group.
usermod -G devs lisa

# bob, data # Make sure "/data" directory is owned by user "bob" and group "devs"
chown bob:devs /data
# group "devs" and "user/group" owner has "full" permissions but "other" should not have any permissions.
chmod 770 /data
# or #
# chown -R bob:devs /data
# chmod -R u+rwx,g+rwx,o-rwx /data

# access control # Give some additional permissions to "admins" group on "/data" directory so that any user who is the member the "admins" group has "full permissions" on this directory.
setfacl -m g:admins:rwx /data

# Sudo # Make sure all users under "admins" group can run all commands with "sudo" and without entering any password.
# echo '%admins ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
# or # 
echo "%admins  ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

# sudo(dnf) # Make sure all users under "devs" group can only run the "dnf" command with "sudo" and without entering any password
# echo '%devs ALL=(ALL) NOPASSWD:/usr/bin/dnf' >> /etc/sudoers
# or # 
echo "%devs  ALL=(ALL) NOPASSWD: /usr/bin/dnf" | sudo tee -a /etc/sudoers

# limits #Configure a "resource limit" for the "devs" group ...
# echo '@devs            -       nproc           30' >> /etc/security/limits.conf
echo '@devs - nproc 30' >> /etc/security/limits.conf

# quota
# Edit the disk quota for the group called "devs"...
setquota -g devs 100M 500M 0 0 /dev/vdb1
