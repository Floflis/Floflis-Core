#!/bin/bash

rocketlaunch_dir=`pwd` #from https://unix.stackexchange.com/a/52919/470623

echo "Downloading updates cache..."
git pull
echo "Checking for updates..."

cd ./updates
lastupdatefind=$(find -maxdepth 1 -name '*.sh' | sort -t_ -nk2,2 | tail -n1)
tmp="${lastupdatefind##*/}" # gives 2.sh
latestupdate="${tmp%.*}"      # gives 2
# inspo for above, from: /media/daniella/B/git/Plasmmer/Plasmmer/GLUE/SharedChain/commonchain.sh
cd "$rocketlaunch_dir"

currentupdate="$(cat lastupdate.txt)"
nextupdate="$(($currentupdate + 1))" #inspo from: /media/daniella/ceb6a175-7104-43d8-8064-48e6ef72cd27/flic/init-new-build.sh

if [ "$latestupdate" -gt "$currentupdate" ]
   then
      echo "New update available! Going to install soon (NOT IMPLEMENTED YET)."
      echo "Currently you have installed: Update $currentupdate ; But there's available: Update $nextupdate to $latestupdate"
   else
      echo "No new update available, yet. Check again later."
fi
