#!/bin/bash

dest_file="/tmp/hrmpf.iso"

if [[ "$1" == start ]]
then
  hrmpf_iso=$(curl -s "https://api.github.com/repos/leahneukirchen/hrmpf/releases/latest" | jq -r '.assets[0].browser_download_url')
  if [[ ! -f "$dest_file" ]]
  then
    echo "-> Download latest hrmpf iso"
    wget "$hrmpf_iso" --quiet -O "/tmp/hrmpf.iso"
  fi
elif [[ "$1" == "stop" ]]
then
  echo "-> Delete hrmpf iso"
  rm "$dest_file"
else
  echo "Please use $0 [start|stop]"
fi
