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
  - [ ] periodic zfs scrub
- [x] port arch-config playbook
  - [ ] README init install git + ansible
  - [ ] create issue wrong missing package reported by xbps module: https://github.com/ansible-collections/community.general/issues
  - [ ] fix GDK_BACKEND=x11 lxappearance
- [ ] travis/github actions on playbook run

ISSUES:
- [ ] xbps role with hooks: https://github.com/void-linux/xbps/issues/304
  - [ ] pre upgrade snapshot hook
    - [x] periodic zfs snapshots with sanoid
  - [ ] post upgrade flatpak upgrade hook
- [ ] keyboard not released with swaymsg exit: https://github.com/void-linux/void-packages/issues/27132
- [ ] xbps ansible module report wrong package error : https://github.com/ansible-collections/community.general/issues/2478

TODO:
- [x] backups to cronie for arch/void
- [ ] move from pulseaudio to pipewire : https://gist.github.com/st3r4g/6c681a28b0403b3b02636f510ff68039

TOTEST:
- openresolv for vpn
- qemu/kvm
- podman

PACKAGES:
- [ ] swaylock-fancy: https://github.com/void-linux/void-packages/issues/27224
- [x] python3-pre-commit: https://github.com/void-linux/void-packages/issues/27225
- [ ] ovmf: https://github.com/void-linux/void-packages/pull/17225
- [ ] kubectx: https://github.com/void-linux/void-packages/pull/17088
- [ ] kustomize: https://github.com/void-linux/void-packages/issues/27230
- [ ] kompose: https://github.com/void-linux/void-packages/issues/27231
- [ ] tutanota: appimage

MERGE:
- [ ] x2goclient:
  - https://github.com/void-linux/void-packages/issues/2091
  - https://github.com/void-linux/void-packages/issues/9779
- [ ] tiny-irc-client: https://github.com/void-linux/void-packages/issues/27180
