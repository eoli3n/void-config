#!/usr/bin/env bash

set -e

print () {
    echo -e "\n\033[1m> $1\033[0m\n"
}

print "Load ZFS module"
modprobe zfs

print "Reimport zpool"
set +e
zpool export zroot
set -e
zpool import -d /dev/disk/by-id -R /mnt zroot -N

print "Load ZFS keys"
zfs load-key zroot

print "Mount slash dataset"
zfs mount zroot/ROOT/default

print "Mount other datasets"
zfs mount -a

print "Mount EFI part"
mount /dev/sda1 /mnt/boot/efi

# Init chroot
mount --rbind /sys /mnt/sys && mount --make-rslave /mnt/sys
mount --rbind /dev /mnt/dev && mount --make-rslave /mnt/dev
mount --rbind /proc /mnt/proc && mount --make-rslave /mnt/proc

# Finish
echo -e "\e[32mAll OK"
