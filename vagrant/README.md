# Using vagrant

## Run

It will automatically download latest [hrmpf](https://github.com/leahneukirchen/hrmpf) iso in /tmp and use it.

```bash
# Run
$ vagrant plugin install vagrant-libvirt
$ vagrant up voidlinux
```

## Remove

``destroy`` subcommand will automatically remove the iso file in /tmp

nvram file is not properly removed, you need to remove it manually before destroying.
https://github.com/vagrant-libvirt/vagrant-libvirt/issues/1371
```bash
$ sudo rm /var/lib/libvirt/qemu/nvram/voidlinux-vagrant.fd
$ vagrant destroy voidlinux
```
