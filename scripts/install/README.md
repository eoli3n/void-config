### How to Use

Boot latest [hrmpf void linux iso](https://github.com/leahneukirchen/hrmpf/releases/latest)

```bash
$ loadkeys fr
$ git clone https://github.com/eoli3n/void-config
$ cd void-config/scripts/install
$ ./01-configure.sh
$ ./02-install.sh
```


### DualBoot Support

After installing Arch Linux with [arch-config](https://github.com/eoli3n/arch-config/tree/master/scripts/zfs/install), run ``01-configure.sh`` and select ``dualboot`` in the menu.

### EFI install

- sda1  
  /efi  
  FAT used as esp
- sda2  
  ZFS pool


##### Installation

``01-configure.sh`` will
- Create partition scheme
- Format everything
- Mount partitions

``02-install.sh`` will
- Configure mirrors
- Install Void Linux and kernel
- Generate initramfs
- Configure hostname, locales, keymap, network
- Install and configure [zfsbootmenu](https://github.com/zbm-dev/zfsbootmenu)
- Generate users and passwords

### Debug

```bash
$ ./01-configure.sh debug
$ ./02-install.sh debug
$ xbps-install -S pastebinit
$ pastebinit -b sprunge.us configure.log
$ pastebinit -b sprunge.us install.log
```
