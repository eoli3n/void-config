#!/usr/bin/env bash

set -e

print () {
    echo -e "\n\033[1m> $1\033[0m\n"
}

print "Umount /boot/efi"
umount /mnt/efi
umount -l /mnt/{dev,proc,sys}
zfs umount -a

print "Export zpool"
zpool export zroot

# Finish
echo -e '\e[32mAll OK\033[0m'
