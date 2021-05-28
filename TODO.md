### TODO
- [x] virt-install scripts
- [x] git pre-commit hooks shellcheck
- [x] install scripts
  - [x] periodic zfs scrub
- [x] port arch-config playbook
  - [ ] README init install git + ansible
- [ ] travis/github actions on playbook run
- [x] backups to cronie for arch/void
- [x] move from pulseaudio to pipewire: https://github.com/void-linux/void-docs/pull/540/commits/33343cbfba36ccd3597d36ee4e983650969b0c7a
- [x] pam_rundir for sway with seatd
- [x] acpid in install script
- [ ] netboot.xyz
- [ ] neomutt, mutt-wizard
  - [ ] packages
  - [ ] config
- [ ] vdirsyncer, khal, khard
  - [ ] packages
  - [ ] config
- [ ] pass, gopass

### TOPACKAGE
- [ ] swaylock-fancy: https://github.com/void-linux/void-packages/issues/27224
- [ ] kubectx: https://github.com/void-linux/void-packages/pull/17088
- [ ] kompose: https://github.com/void-linux/void-packages/issues/27231
- [ ] veyon
- [ ] gopass-jsonapi: https://github.com/void-linux/void-packages/issues/31155
- [ ] ydotool: https://github.com/void-linux/void-packages/issues/31163

### TOMERGE
- [x] x2goclient:
  - https://github.com/void-linux/void-packages/issues/2091
  - https://github.com/void-linux/void-packages/issues/9779
- [ ] x2goserver
- [x] tiny: https://github.com/void-linux/void-packages/issues/27180
- [ ] python3-pre-commit: https://github.com/void-linux/void-packages/issues/27225
- [ ] ovmf: https://github.com/void-linux/void-packages/pull/29074
  - [x] local build

### TOTEST
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
- [x] firmware updater
- [ ] lid switch

### TOFIX
- [x] flatpak not showing in wofi
- [x] flatpak app no access to home
- [x] $ fwupdmgr get-devices: https://github.com/fwupd/fwupd/issues/3255
- [ ] vpn: ssh delay
- [ ] pipewire warnings : "RTKit error: org.freedesktop.DBus.Error.AccessDenied"
  - [ ] rtkit service error : "pthread_create failed: Resource temporarily unavailable"
- [ ] pipewire killed after hibernation ?
- [ ] libgl1 32bit missing for steam
- [ ] freebox vpn: connection ok, but no network
- [ ] dht/pex ?

### ISSUES
- [ ] xbps role with hooks: https://github.com/void-linux/xbps/issues/304
  - [ ] pre upgrade snapshot hook
    - [x] periodic zfs snapshots with sanoid
  - [ ] post upgrade flatpak upgrade hook
- [x] keyboard not released with swaymsg exit: https://github.com/void-linux/void-packages/issues/27132
- [ ] wrong missing package reported by xbps module: https://github.com/ansible-collections/community.general/issues/2478
  - [x] workaround by using loop

### RESOURCES

- https://docs.voidlinux.org/installation/guides/chroot.html
- https://wiki.voidlinux.org/Manual_install_with_ZFS_root
- https://github.com/nightah/void-install
- neffi@freenode#voidlinux zfsbootmenu config: http://ix.io/2I4m

```
podman run --rm -it voidlinux/voidlinux /bin/sh
podman run --rm -it voidlinux/voidlinux-musl /bin/sh
```
