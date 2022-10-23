#!/bin/bash
# See https://unix.stackexchange.com/a/265492

if ! which syncoid
then
  echo "Please install sanoid."
  exit 0
fi

# Stop zrepl during transfert
sudo sv stop zrepl

# Ask for dest IP
read -rp "Host ip : " ip

# Authorize ssh key
sudo ssh-copy-id "root@$ip"

# Send all datasets/snapshots on the destpool
sudo syncoid -r zroot "root@$ip":zroot

# Restart zrepl
sudo sv start zrepl
