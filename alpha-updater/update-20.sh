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
      echo "New update available!"
      echo "Currently you have installed: Update $currentupdate ; But there's available: Update(s) $nextupdate to $latestupdate."
#loopmile="5" #inspo from /media/daniella/B/git/Gamlr/Gamlr/tools/list-construct-addons/get-c2-proj-addons.sh
until [[ "$currentupdate" = "$latestupdate" ]]
do
echo "Installing Update $nextupdate..."
cd ./updates
bash "$nextupdate.sh"
cd "$rocketlaunch_dir"
echo "$nextupdate" > lastupdate.txt
currentupdate="$(cat lastupdate.txt)" #update the variable
nextupdate="$(($currentupdate + 1))" #update the variable
wait 1s
#   loopmile="$(($loopmile + 1))"
#   #echo "Get: $addonIDprepare"
#   #echo "Current loop: $loopmile"
#   #if [[ "$addonIDprepare" != "" ]]; then echo "Current loop: $loopmile"; else echo "Stopped at loop: $loopmile"; fi
#   #if [[ "$addonIDprepare" = "" ]]; then echo "Current loop: $loopmile"; else echo "Stopped at loop: $loopmile"; fi
#   #echo "Get: $addonIDprepare"
#   #echo "-"
#   addonIDprepare="$(cat *.caproj | grep -oE ".?version[^<>]*>[^<>]+" | cut -d'>' -f2 | sed -n "$loopmile p")"
#   if [[ "$currentupdate" != "$latestupdate" ]]; then echo "Current loop: $loopmile"; else echo "Stopped at loop: $loopmile"; fi
#   if [[ "$addonIDprepare" != "" ]]; then echo "Get: $addonIDprepare";echo "-"; fi
done
#loopmile="0"
   else
      echo "No new update available, yet. Check again later."
      echo "Currently you have installed: Update $currentupdate."
fi
