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

Boot latest [hrmpf void linux iso](https://github.com/leahneukirchen/hrmpf/releases/latest)

```bash
$ loadkeys fr
$ git clone https://github.com/eoli3n/void-config
$ cd void-config/scripts/install
$ ./01-configure.sh
$ ./02-install.sh
```

##### Debug

```bash
$ ./01-configure.sh debug
$ ./02-install.sh debug
$ xbps-install -S pastebinit
$ pastebinit -b sprunge.us configure.log
$ pastebinit -b sprunge.us install.log
```
