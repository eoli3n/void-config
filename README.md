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
  - [x] periodic zfs scrub
- [x] port arch-config playbook
  - [ ] README init install git + ansible
- [ ] travis/github actions on playbook run

### ISSUES
- [ ] xbps role with hooks: https://github.com/void-linux/xbps/issues/304
  - [ ] pre upgrade snapshot hook
    - [x] periodic zfs snapshots with sanoid
  - [ ] post upgrade flatpak upgrade hook
- [x] keyboard not released with swaymsg exit: https://github.com/void-linux/void-packages/issues/27132
- [ ] wrong missing package reported by xbps module: https://github.com/ansible-collections/community.general/issues/2478
  - [x] workaround by using loop

### TODO
- [x] backups to cronie for arch/void
- [x] move from pulseaudio to pipewire: https://github.com/void-linux/void-docs/pull/540/commits/33343cbfba36ccd3597d36ee4e983650969b0c7a
- [x] pam_rundir for sway with seatd
- [x] acpid in install script
- [ ] netboot.xyz

### PACKAGES
- [ ] swaylock-fancy: https://github.com/void-linux/void-packages/issues/27224
- [x] python3-pre-commit: https://github.com/void-linux/void-packages/issues/27225
- [ ] ovmf: https://github.com/void-linux/void-packages/pull/17225
- [ ] kubectx: https://github.com/void-linux/void-packages/pull/17088
- [ ] kustomize: https://github.com/void-linux/void-packages/issues/27230
- [ ] kompose: https://github.com/void-linux/void-packages/issues/27231
- [ ] veyon

### MERGE
- [x] x2goclient:
  - https://github.com/void-linux/void-packages/issues/2091
  - https://github.com/void-linux/void-packages/issues/9779
- [ ] x2goserver
- [x] tiny: https://github.com/void-linux/void-packages/issues/27180

### TESTS

- [x] auto zfs sanoid snapshots with cronie
- [x] ntp
- [x] check daemons log with socklog
```
less /var/log/socklog/everything/current
```
- [x] vpn and openresolv update dns script
- [x] backups
- [x] hibernation with zzz
- [x] pipewire
- [x] qemu/kvm
- [x] podman
- [x] flatpaks
- [ ] firmware updater
- [ ] lid switch

### TOFIX
- [ ] qemu/kvm: long time to display screen from vpn
- [ ] pipewire warnings : "RTKit error: org.freedesktop.DBus.Error.AccessDenied"
  - [ ] rtkit service error : "pthread_create failed: Resource temporarily unavailable"
- [x] flatpak not showing in wofi
- [ ] libgl1 32bit missing for steam
- [ ] freebox vpn: connection ok, but no network
- [ ] $ fwupdmgr get-devices
      WARNING: Required efivarfs filesystem was not found
      See https://github.com/fwupd/fwupd/wiki/PluginFlag:efivar-not-mounted for more information.
      workaround : modprobe efivars && mount -t efivarfs efivarfs /sys/firmware/efi/efivars
      fwupdmgr still complaining but ls /sys/firmware/efi/efivars show vars
      issue : https://github.com/fwupd/fwupd/issues/3255
Latitude 7490
