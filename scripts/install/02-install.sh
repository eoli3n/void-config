#!/bin/bash

set -e
# Debug
#set -x
#trap read debug

print () {
    echo -e "\n\033[1m> $1\033[0m\n"
}

# Set mirror and architecture
REPO=https://alpha.de.repo.voidlinux.org/current
ARCH=x86_64

### Install base system
print 'Install Void Linux'
XBPS_ARCH=$ARCH xbps-install -S -r /mnt -R "$REPO" \
  base-system \
  void-repo-nonfree \

# Init chroot
mount --rbind /sys /mnt/sys && mount --make-rslave /mnt/sys
mount --rbind /dev /mnt/dev && mount --make-rslave /mnt/dev
mount --rbind /proc /mnt/proc && mount --make-rslave /mnt/proc

# Install packages
XBPS_ARCH=$ARCH xbps-install -S -r /mnt -R "$REPO" \
  intel-ucode \
  zfs \
  zfsbootmenu \
  efibootmgr \
  refind \
  gummiboot \
  connman

# Set hostname
echo 'Please enter hostname :'
read -r hostname
echo "$hostname" > /mnt/etc/hostname

# Configure network
cat >> /mnt/etc/sv/connmand/conf <<"EOF"
OPTS="--nodnsproxy"
EOF
chroot /mnt ln -s /etc/sv/connmand /etc/runit/runsvdir/default/

# Configure DNS
cat >> /mnt/etc/resolv.conf <<"EOF"
nameserver 1.1.1.1
nameserver 9.9.9.9
EOF

# Prepare locales and keymap
print 'Prepare locales and keymap'
echo 'KEYMAP=fr' > /mnt/etc/vconsole.conf
echo 'fr_FR.UTF-8 UTF-8' > /mnt/etc/default/libc-locales
echo 'LANG="fr_FR.UTF-8"' > /mnt/etc/locale.conf

# Configure system
cat >> /mnt/etc/rc.conf << EOF
KEYMAP="fr"
TIMEZONE="Europe/Paris"
HARDWARECLOCK="UTC"
EOF

# Configure dracut
print 'Configure dracut'
cat > /mnt/etc/dracut.conf.d/zol.conf <<"EOF"
hostonly="yes"
nofsck="yes"
add_dracutmodules+=" zfs "
omit_dracutmodules+=" btrfs resume "
EOF

### Chroot
chroot /mnt/ /bin/bash -xe <<"EOF"
  # Generates locales
  xbps-reconfigure -f glibc-locales

  # Add user
  useradd -m user

  # Generate fstab excluding zfs parts
  egrep -v "proc|sys|devtmpfs|pts|zfs" /proc/mounts > /etc/fstab

EOF

# Configure /tmp
cat >> /mnt/etc/fstab <<"EOF"
tmpfs           /tmp        tmpfs   defaults,nosuid,nodev   0 0
EOF

# Set root passwd
print 'Set root password'
chroot /mnt /bin/passwd

# Set user passwd
print 'Set user password'
chroot /mnt /bin/passwd user

# Configure sudo
print 'Configure sudo'
cat > /mnt/etc/sudoers <<"EOF"
root ALL=(ALL) ALL
user ALL=(ALL) ALL
Defaults rootpw
EOF

### Configure zfsbootmenu

# Create dirs
mkdir -p /mnt/boot/efi/EFI/ZBM /mnt/boot/zfsbootmenu /etc/zfsbootmenu/dracut.conf.d

# Copy zfs hostid
cp /etc/hostid /mnt/etc/hostid

# Generate zfsbootmenu efi
print 'Configure zfsbootmenu'
cat > /mnt/etc/zfsbootmenu/config.yaml <<EOF
Global:
  ManageImages: true
  BootMountPoint: /boot/efi
  DracutConfDir: /etc/zfsbootmenu/dracut.conf.d
Components:
  Enabled: false
EFI:
  ImageDir: /boot/efi/EFI/ZBM
  Versions: 1
  Enabled: true
Kernel:
  CommandLine: ro quiet loglevel=0 spl_hostid=$(hostid) net.ifnames=0
EOF

# Generate ZBM and install refind
print 'Generate zbm and install refind'
chroot /mnt/ /bin/bash -xe <<"EOF"

  # Export locale
  export LANG="fr_FR.UTF-8"

  # Generate ZBM
  generate-zbm

  # Install bootloader
  refind-install

  # Generate initramfs
  xbps-reconfigure -fa
EOF

# Configure refind
print 'Configure refind'
cat > /mnt/boot/efi/EFI/ZBM/refind_linux.conf <<EOF
"Boot Default BE" "ro quiet loglevel=0 timeout=0 root=zfsbootmenu:POOL=zroot spl_hostid=$(hostid)"
"Select BE" "ro quiet loglevel=0 timeout=-1 root=zfsbootmenu:POOL=zroot spl_hostid=$(hostid)"
EOF

# Umount all parts
print 'Umount all parts'
umount /mnt/boot/efi
umount -l /mnt/{dev,proc,sys}
zfs umount -a

# Export zpool
print 'Export zpool'
zpool export zroot

# Finish
echo -e '\e[32mAll OK\033[0m'
