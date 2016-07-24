#!/bin/bash

set -ex
username=$1

# Enable wheel
sed -i '/^# %wheel ALL=(ALL) NOPASSWD: ALL/s/^#//' /etc/sudoers

# Create an user
userfolder=/home/$username
useradd -m -d $userfolder $username
usermod -a -G wheel $username

install -d -m 700 $userfolder/.ssh
install -b -m 644 /dev/null $userfolder/.ssh/authorized_keys
cat /vagrant/vagrant/id_rsa.pub > $userfolder/.ssh/authorized_keys
chown -R $username:$username $userfolder/.ssh

# Add a permition for current user to ssh in
sed -i "/^AllowUsers vagrant/ s/$/ $username/" /etc/ssh/sshd_config
systemctl restart sshd
