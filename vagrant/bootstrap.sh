#!/bin/sh

set -e

# Shared folder provided by vagrant.
basedir='/vagrant'

# Execute specific script
if [ -x /usr/bin/pacman ]; then
  exec $basedir/vagrant/arch.sh
fi
if [ -x /usr/bin/apt-get ]; then
  exec $basedir/vagrant/ubuntu.sh
fi
if [ -x /usr/bin/yum ]; then
  exec $basedir/vagrant/centos.sh
fi
