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
