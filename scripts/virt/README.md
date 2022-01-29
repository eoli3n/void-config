# Using vagrant

WIP

```bash
# Run
$ vagrant plugin install vagrant-host-shell
$ vagrant up voidlinux
# Clean
$ vagrant destroy voidlinux
$ rm /tmp/hrmpf.iso
```

# Using scripts

### Create VM

It will download iso, create UEFI VM and run it for Qemu/KVM.

```
#glibc
sudo ./00-create.sh
#musl
sudo ./00-create.sh musl
#hrmpf
sudo ./00-create.sh hrmpf
```

### Clean

It removes VMs

```
sudo ./01-clean.sh
```
