#!/bin/bash

rocketlaunch_dir=`pwd` #from https://unix.stackexchange.com/a/52919/470623

cd ./updates
lastupdatefind=$(find -maxdepth 1 -name '*.sh' | sort -t_ -nk2,2 | tail -n1)
tmp="${lastupdatefind##*/}" # gives 2.sh
lastupdate="${tmp%.*}"      # gives 2
# inspo for above, from: /media/daniella/B/git/Plasmmer/Plasmmer/GLUE/SharedChain/commonchain.sh
cd "$rocketlaunch_dir"

if [ "$lastupdate" -gt "$(cat lastupdate.txt)" ]
   then
      echo "New update available! Going to install soon (NOT IMPLEMENTED YET)."
   else
      echo "No new update available, yet. Check again later."
fi

if [ "$(cinnamon --version)" = "$(cat lastupdate.txt)" ];
then
   echo ""
#   sudo cp -f js/ui/panel.js /usr/share/cinnamon/js/ui/
fi

if [ "$(cinnamon --version)" = "$(cat lastupdate.txt)" ];
then
   echo ""
else
   echo ""
#   echo "Expected/supported version: Cinnamon $(cat currentversion.txt)"
#   echo "Your current version: $(cinnamon --version)"
fi
