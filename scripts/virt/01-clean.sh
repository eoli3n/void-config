#!/bin/bash

clean (){
  echo "-> Destroy $1"
  virsh destroy "$1"
  echo "-> Undefine $1"
  virsh undefine --nvram "$1"
  echo "-> Remove $1 qcow"
  rm "/var/lib/libvirt/images/$1.img"
}

if virsh list | grep void-linux-glibc &>/dev/null
then
  clean "void-linux-glibc"
elif virsh list | grep void-linux-musl &>/dev/null
then
  clean "void-linux-musl"
elif virsh list | grep void-linux-hrmpf &>/dev/null
then
  clean "void-linux-hrmpf"
fi
