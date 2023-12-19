#!/bin/sh

if cat /proc/1/cgroup | tail -1 | grep -q "container"; then
  echo "linux container. Floflis' firstboot won't run."
else
  full_fs=$(df ~ | tail -1 | awk '{print $1;}')  # /dev/sda1
  fs=$(basename $full_fs)                        # sda1
  if grep -q "$fs" /proc/partitions; then
    echo "regular linux install. Floflis' firstboot will proceed."
  else
    echo "live OS running from RAM. Floflis' firstboot won't run."
  fi
fi

if [ "$(df ~ | tail -1 | awk '{print $1;}')" = "/cow" ]; then
   echo "Live ISO detected. Will exit?"
   exit
fi

echo "Didn't exited."
