#!/bin/bash

set -e

print () {
    echo -e "\n\033[1m> $1\033[0m\n"
}

# Set mirror and architecture
REPO=https://alpha.de.repo.voidlinux.org/current
ARCH=x86_64

# Install
print "Install Void Linux"
XBPS_ARCH=$ARCH xbps-install -S -r /mnt -R "$REPO" base-system grub intel-ucode zfs

# Init chroot
mount --rbind /sys /mnt/sys && mount --make-rslave /mnt/sys
mount --rbind /dev /mnt/dev && mount --make-rslave /mnt/dev
mount --rbind /proc /mnt/proc && mount --make-rslave /mnt/proc

# Set hostname
echo "Please enter hostname :"
read -r hostname
echo "$hostname" > /mnt/etc/hostname

# Prepare locales and keymap
print "Prepare locales and keymap"
echo "KEYMAP=fr" > /mnt/etc/vconsole.conf
sed -i 's/#\(fr_FR.UTF-8 UTF.8\)/\1/' /mnt/etc/default/libc-locales

# Configure system
cat >> /mnt/etc/rc.conf << EOF
KEYMAP="fr"
TIMEZONE="Europe/Paris"
HARDWARECLOCK="UTC"
EOF

# Generate zfs hostid
ip link show | awk '/ether/ {gsub(":","",$2); print $2; exit}' > /mnt/etc/hostid

# Run chroot
chroot /mnt/ /bin/bash -xe <<"EOF"

  # Upgrade
  xbps-install -Su xbps
  xbps-install -u
  xbps-install base-system
  xbps-remove base-voidstrap

  # Generates locales
  xbps-reconfigure -f glibc-locales

  # Add user
  useradd -m user

  # Generate fstab excluding zfs parts
  egrep -v "proc|sys|devtmpfs|pts|zfs" /proc/mounts > /etc/fstab
EOF

# Set root passwd
print "Set root password"
chroot /mnt /bin/passwd

# Set user passwd
print "Set user password"
chroot /mnt /bin/passwd user

# Configure sudo
print "Configure sudo"
cat > /mnt/etc/sudoers <<"EOF"
root ALL=(ALL) ALL
user ALL=(ALL) ALL
Defaults rootpw
EOF

# Configure dracut
print "Configure dracut"
cat > /mnt/etc/dracut.conf.d/zol.conf <<"EOF"
hostonly="yes"
nofsck="yes"
add_dracutmodules+=" zfs "'
omit_dracutmodules+=" btrfs resume "'
EOF

# Generate initramfs
print "Generate initramfs"
xbps-reconfigure -f linux4.14
