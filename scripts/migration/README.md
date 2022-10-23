# Send home from first host

On hrmpf
```bash
$ passwd
# Change to PermitRootLogin yes in sshd_config
$ sv restart sshd
$ ./01-load-pool.sh
```

On sending client
Create a ssh key pair and run send script

```bash
$ sudo ssh-keygen -t rsa
$ ./02-zfs-send.sh
```

