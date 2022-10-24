# Send home from first host

On hrmpf
```bash
$ passwd
# Change to PermitRootLogin yes in sshd_config
$ sv restart sshd
$ ./01-configure.sh
$ ./02-load-pool.sh
```

On sending client
Create a ssh key pair and run send script

```bash
$ sudo ssh-keygen -t rsa
$ ./03-zfs-send.sh
$ ./04-mount.sh
$ ./05-generate-zbm.sh
```

