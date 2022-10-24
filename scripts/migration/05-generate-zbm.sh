#!/bin/bash

chroot /mnt/ /bin/bash -e <<EOF
  generate-zbm
EOF
