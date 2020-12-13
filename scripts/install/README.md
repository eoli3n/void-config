### EFI install

- sda1
  /efi
  FAT used as esp
- sda2
  ZFS pool


##### Boot latest arch iso

``01-configure.sh`` will
- Create partition scheme
- Format everything
- Mount partitions

``02-install.sh`` will
- Configure mirrors ???
- Install Void Linux and kernel
- Generate initramfs
- Configure hostname, locales, keymap, network
- Install and configure bootloader
- Generate users and passwords

Boot latest void linux iso

```
#login with root:voidlinux
loadkeys fr
bash
xbps-install -S
xbps-install -y git
git clone https://github.com/eoli3n/void-config
cd void-config/scripts/install
./01-configure.sh
./02-install.sh
```
