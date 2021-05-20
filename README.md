### ZFS root install

- Native encryption aes-256-gcm
- Zstd compression on all datasets
- Boot Environments managed with [zfsbootmenu](https://github.com/zdykstra/zfsbootmenu)
- No swap
- Separated VFAT /boot

### Install

- Clone me
```
git clone https://github.com/eoli3n/void-config
```
- Run OS installer at [scripts/install/](scripts/install/)
- Install packages and configurations with [ansible](ansible/README.md)
- Use [dotfiles](https://github.com/eoli3n/dotfiles)
