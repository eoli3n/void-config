[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

- https://docs.voidlinux.org/installation/guides/chroot.html
- https://wiki.voidlinux.org/Manual_install_with_ZFS_root
- https://github.com/nightah/void-install
- neffi@freenode#voidlinux zfsbootmenu config: http://ix.io/2I4m

```
podman run --rm -it voidlinux/voidlinux /bin/sh
podman run --rm -it voidlinux/voidlinux-musl /bin/sh
```

- [x] virt-install scripts
- [x] git pre-commit hooks shellcheck
- [ ] install scripts
  - [x] zfs parts
  - [x] system install
  - [ ] network, dns
  - [ ] no bootloader and zfsbootmenu test
- [ ] port arch-config playbook + git hook ansible-playbook --syntax-check
- [ ] zectl with syslinux: https://github.com/johnramsden/zectl/issues/35
- [ ] travis/github actions on playbook run
