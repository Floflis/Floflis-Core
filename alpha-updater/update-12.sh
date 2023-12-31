#!/bin/bash

rocketlaunch_dir=`pwd` #from https://unix.stackexchange.com/a/52919/470623

cd ./updates
lastupdatefind=$(find -maxdepth 1 -name '*.sh' | sort -t_ -nk2,2 | tail -n1)
tmp="${lastupdatefind##*/}" # gives 2.sh
latestupdate="${tmp%.*}"      # gives 2
# inspo for above, from: /media/daniella/B/git/Plasmmer/Plasmmer/GLUE/SharedChain/commonchain.sh
cd "$rocketlaunch_dir"

if [ "$latestupdate" -gt "$(cat lastupdate.txt)" ]
   then
      echo "New update available! Going to install soon (NOT IMPLEMENTED YET)."
      echo "Currently you have installed: Update $(cat lastupdate.txt) ; But there's available: Update $latestupdate"
   else
      echo "No new update available, yet. Check again later."
fi
