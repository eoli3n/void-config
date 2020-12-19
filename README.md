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
- [x] install scripts
  - [x] zfs parts
  - [x] system install
  - [x] refind and zfsbootmenu
  - [x] network, dns
  - [x] ntp with chrony
  - [x] crond with cronie
  - [x] tlp: https://docs.voidlinux.org/config/power-management.html
  - [ ] periodic zfs scrub
- [x] port arch-config playbook
  - [x] git hook ansible-playbook --syntax-check
  - [x] create package requests for missings
    - [x] workaround kubectx kubens pre-commit
  - [ ] README init install git + ansible
  - [ ] create issue wrong missing package reported by xbps module: https://github.com/ansible-collections/community.general/issues
  - [x] move xbps tasks from loop to name: list
  - [ ] fix GDK_BACKEND=x11 lxappearance
  - [ ] xbps role with hooks: https://github.com/void-linux/xbps/issues/304
    - [ ] pre upgrade snapshot hook
    - [ ] post upgrade flatpak upgrade hook
- [ ] travis/github actions on playbook run

issues:
- https://sourceforge.net/p/refind/discussion/general/thread/4dfcdfdd16/

TODO:
- backups to cronie for arch/void

TOFIX:
- openresolv for vpn

PACKAGES:
- [ ] x2goclient:
  - https://github.com/void-linux/void-packages/issues/2091
  - https://github.com/void-linux/void-packages/issues/9779
- [ ] tiny-irc-client: https://github.com/void-linux/void-packages/issues/27180
- [ ] swaylock-fancy: https://github.com/void-linux/void-packages/issues/27224
- [ ] python3-pre-commit: https://github.com/void-linux/void-packages/issues/27225
- [ ] ovmf: https://github.com/void-linux/void-packages/pull/17225
- [ ] kubectx: https://github.com/void-linux/void-packages/pull/17088
- [ ] kustomize: https://github.com/void-linux/void-packages/issues/27230
- [ ] kompose: https://github.com/void-linux/void-packages/issues/27231
