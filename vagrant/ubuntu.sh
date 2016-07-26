#!/bin/bash

set -ex

username=$1
userfolder=/home/$username

### Install dependencies
apt-get update
apt-get -y install curl

# Create an user
useradd -m -d $userfolder $username

install -d -m 700 $userfolder/.ssh
install -b -m 644 /dev/null $userfolder/.ssh/authorized_keys
cat /vagrant/vagrant/id_rsa.pub > $userfolder/.ssh/authorized_keys
chown -R $username:$username $userfolder/.ssh
echo "$username ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
