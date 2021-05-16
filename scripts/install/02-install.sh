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

# Disable gummiboot post install hooks, only installs for generate-zbm
echo "GUMMIBOOT_DISABLE=1" > /mnt/etc/default/gummiboot

# Install packages
packages=(
  intel-ucode
  zfs
  zfsbootmenu
  efibootmgr
  gummiboot # required by zfsbootmenu
  chrony # ntp
  cronie # cron
  seatd # minimal seat management daemon, required by sway
  acpid # power management
  socklog-void # syslog daemon
  iwd # wifi daemon
  dhclient
  openresolv # dns
  git
  ansible
  )

XBPS_ARCH=$ARCH xbps-install -S -r /mnt -R "$REPO" "${packages[@]}"

# Set hostname
read -r -p 'Please enter hostname : ' hostname
echo "$hostname" > /mnt/etc/hostname

# Configure iwd
cat > /mnt/etc/iwd/main.conf <<"EOF"
[General]
UseDefaultInterface=true
EnableNetworkConfiguration=true
EOF

# Configure DNS
cat >> /mnt/etc/resolvconf.conf <<"EOF"
resolv_conf=/etc/resolv.conf
name_servers="1.1.1.1 9.9.9.9"
EOF

# Enable ip forward
cat > /mnt/etc/sysctl.conf <<"EOF"
net.ipv4.ip_forward = 1
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
install_items+=" /etc/zfs/zroot.key "
EOF

### Chroot
print 'Chroot to configure services'
chroot /mnt/ /bin/bash -e <<"EOF"
  # Configure DNS
  resolvconf -u

  # Configure services
  ln -s /etc/sv/dhcpcd-eth0 /etc/runit/runsvdir/default/
  ln -s /etc/sv/iwd /etc/runit/runsvdir/default/
  ln -s /etc/sv/chronyd /etc/runit/runsvdir/default/
  ln -s /etc/sv/crond /etc/runit/runsvdir/default/
  ln -s /etc/sv/dbus /etc/runit/runsvdir/default/
  ln -s /etc/sv/seatd /etc/runit/runsvdir/default/
  ln -s /etc/sv/acpid /etc/runit/runsvdir/default/
  ln -s /etc/sv/socklog-unix /etc/runit/runsvdir/default/
  ln -s /etc/sv/nanoklogd /etc/runit/runsvdir/default/

  # Generates locales
  xbps-reconfigure -f glibc-locales

  # Add user
  useradd -m user -G network,wheel,socklog,video,audio,_seatd

  # Generate fstab excluding zfs parts
  egrep -v "proc|sys|devtmpfs|pts|zfs" /proc/mounts > /etc/fstab
EOF

# Configure /tmp
cat >> /mnt/etc/fstab <<"EOF"
tmpfs           /tmp        tmpfs   defaults,nosuid,nodev   0 0
efivarfs /sys/firmware/efi/efivars efivarfs defaults 0 0
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

# Configure zfs
cp /etc/hostid /mnt/etc/hostid
cp /etc/zfs/zpool.cache /mnt/etc/zfs/zpool.cache
cp /etc/zfs/zroot.key /mnt/etc/zfs

### Configure zfsbootmenu

# Create dirs
mkdir -p /mnt/efi/EFI/ZBM /etc/zfsbootmenu/dracut.conf.d

# Config keymap as https://github.com/zbm-dev/zfsbootmenu/issues/96#issuecomment-745627427
mkdir -p /mnt/etc/cmdline.d
echo 'rd.vconsole.keymap=fr' > /mnt/etc/cmdline.d/keymap.conf
echo 'install_optional_items+=" /etc/cmdline.d/keymap.conf "' > /mnt/etc/zfsbootmenu/dracut.conf.d/keymap.conf

# Generate zfsbootmenu efi
print 'Configure zfsbootmenu'
cat > /mnt/etc/zfsbootmenu/config.yaml <<EOF
Global:
  ManageImages: true
  BootMountPoint: /efi
  DracutConfDir: /etc/zfsbootmenu/dracut.conf.d
Components:
  Enabled: false
EFI:
  ImageDir: /efi/EFI/ZBM
  Versions: false
  Enabled: true
Kernel:
  CommandLine: ro quiet loglevel=0
EOF

# Generate ZBM
print 'Generate zbm'
chroot /mnt/ /bin/bash -e <<"EOF"

  # Export locale
  export LANG="fr_FR.UTF-8"

  # Generate ZBM
  generate-zbm

  # Generate initramfs
  xbps-reconfigure -fa
EOF

# Set cmdline
zfs set org.zfsbootmenu:commandline="ro quiet" zroot/ROOT

# Create UEFI entries
efibootmgr --disk /dev/sda \
  --part 1 \
  --create \
  --label "ZFSBootMenu Backup" \
  --loader "\EFI\ZBM\vmlinuz-backup.efi" \
  --unicode "root=zfsbootmenu:POOL=zroot ro quiet spl_hostid=$(hostid)" \
  --verbose
efibootmgr --disk /dev/sda \
  --part 1 \
  --create \
  --label "ZFSBootMenu" \
  --loader "\EFI\ZBM\vmlinuz.efi" \
  --unicode "root=zfsbootmenu:POOL=zroot ro quiet spl_hostid=$(hostid)" \
  --verbose

# Umount all parts
print 'Umount all parts'
umount /mnt/efi
umount -l /mnt/{dev,proc,sys}
zfs umount -a

# Export zpool
print 'Export zpool'
zpool export zroot

# Finish
echo -e '\e[32mAll OK\033[0m'
