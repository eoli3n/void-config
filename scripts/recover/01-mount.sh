#!/usr/bin/env bash

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
zpool import -d /dev/disk/by-id -R /mnt zroot -N

print "Load ZFS keys"
zfs load-key zroot

print "Mount ROOT dataset"
select ENTRY in $(zfs list | awk '/ROOT\// {print $1}')
do
    echo "Mount $ENTRY as slash dataset."
    zfs mount "$ENTRY"
done


print "Mount datasets"
zfs mount -a

print "Mount EFI part"
mount /dev/sda1 /mnt/efi

# Init chroot
mount --rbind /sys /mnt/sys
mount --make-rslave /mnt/sys
mount --rbind /dev /mnt/dev
mount --make-rslave /mnt/dev
mount --rbind /proc /mnt/proc
mount --make-rslave /mnt/proc

# Finish
echo -e '\e[32mAll OK\033[0m'
