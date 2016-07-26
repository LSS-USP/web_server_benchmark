#!/bin/sh

set -e
username=$1

# Shared folder provided by vagrant.
basedir='/vagrant'

# Execute specific script
if [ -x /usr/bin/pacman ]; then
  exec $basedir/vagrant/arch.sh $username
fi
if [ -x /usr/bin/apt-get ]; then
  exec $basedir/vagrant/ubuntu.sh $username
fi
if [ -x /usr/bin/yum ]; then
  exec $basedir/vagrant/centos.sh
fi
