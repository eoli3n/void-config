# Send home from first host

On hrmpf
```bash
$ passwd
# Change to PermitRootLogin yes in sshd_config
$ sv restart sshd
```

On sending client
```bash
$ ./01-load-pool.sh
$ ./02-zfs-send.sh
```

