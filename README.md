[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

### ZFS root install

- Native encryption aes-256-gcm
- Zstd compression on all datasets
- Boot Environments managed with [zfsbootmenu](https://github.com/zdykstra/zfsbootmenu)
- No swap

### Install

- Clone me
```
git clone https://github.com/eoli3n/void-config
```
- Run OS installer at [scripts/install/](scripts/install/)
- Install packages and configurations with [ansible](ansible/)
- Use [dotfiles](https://github.com/eoli3n/dotfiles)
