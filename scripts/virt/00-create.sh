#!/bin/bash

# List os-variant: osinfo-query os
iso_path="/home/isos"

if [[ "$1" == "musl" ]]
then

  # Get latest musl iso name
  base_musl_iso=$(curl -s https://alpha.de.repo.voidlinux.org/live/current/ | grep -m 1 -Eo 'void-live-x86_64-musl-[0-9]{8}.iso' | head -n1)
  # Download musl iso
  base_musl_iso_path="${iso_path}/${base_musl_iso}"
  if ! test -f "${base_musl_iso_path}"
  then
    echo "-> Download latest musl iso"
    wget "https://alpha.de.repo.voidlinux.org/live/current/${base_musl_iso}" -O "${base_musl_iso_path}"
  fi

  # Set VM vars
  name="void-linux-musl"
  description="Test Void Linux with musl"
  iso="${base_musl_iso_path}"

else
  # Get latest glibc iso name
  base_iso=$(curl -s https://alpha.de.repo.voidlinux.org/live/current/ | grep -m 1 -Eo 'void-live-x86_64-[0-9]{8}.iso' | head -n1)
  # Download glibc iso
  base_iso_path="${iso_path}/${base_iso}"
  if ! test -f "${base_iso_path}"
  then
    echo "-> Download latest glibc iso"
    wget "https://alpha.de.repo.voidlinux.org/live/current/${base_iso}" -O "${base_iso_path}"
  fi

  # Set VM vars
  name="void-linux-glibc"
  description="Test Void Linux with glibc"
  iso="${base_iso_path}"

fi

# Create VM
echo "-> Create VM"
virt-install \
  -n "${name}" \
  --description "${description}" \
  --os-type=Linux \
  --os-variant=voidlinux \
  --ram=2048 \
  --vcpus=2 \
  --cpu host \
  --boot uefi \
  --disk path=/var/lib/libvirt/images/${name}.img,bus=virtio,size=30 \
  --graphics spice \
  --video qxl \
  --channel spicevmc \
  --check all=off \
  --noautoconsole \
  --cdrom "${iso}"
#  --network bridge:br0
