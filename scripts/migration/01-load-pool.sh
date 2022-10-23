#!/usr/bin/env bash

set -e

print () {
    echo -e "\n\033[1m> $1\033[0m\n"
}

print "Load ZFS module"
modprobe zfs

print "Reimport zpool"
if zpool status zroot &>/dev/null
then
  zpool export zroot
fi
zpool import -d /dev/disk/by-id -R /mnt zroot -N -f

print "Load ZFS keys"
zfs load-key -L prompt zroot

# Finish
echo -e '\e[32mAll OK\033[0m'
