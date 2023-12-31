#!/bin/bash

rocketlaunch_dir=`pwd` #from https://unix.stackexchange.com/a/52919/470623

# would detect fakeroot 
#for path in ${LD_LIBRARY_PATH//:/ }; do
#   if [[ "$path" == *libfakeroot ]]
#      then
#         echo "You're using fakeroot. Floflis won't work."
#         exit
#fi
#done
is_root=false
if [ "$([[ $UID -eq 0 ]] || echo "Not root")" = "Not root" ]
   then
      is_root=false
   else
      is_root=true
fi
maysudo=""
if [ "$is_root" = "false" ]
   then
      maysudo="sudo"
   else
      maysudo=""
fi

echo "Downloading updates cache (Core)..."
git pull
echo "Checking for updates (Core)..."

cd ./updates
lastupdatefind=$(find -maxdepth 1 -name '*.sh' | sort -t_ -nk2,2 | tail -n1)
tmp="${lastupdatefind##*/}" # gives 2.sh
latestupdate="${tmp%.*}"      # gives 2
# inspo for above, from: /media/daniella/B/git/Plasmmer/Plasmmer/GLUE/SharedChain/commonchain.sh
cd "$rocketlaunch_dir"

#pastupdate="$(cat lastupdate.txt)" #this variable won't change along the script; keep to know in which update it was before the script began workn.
currentupdate="$(cat lastupdate.txt)"
pastupdate="$currentupdate" #this variable won't change along the script; keep to know in which update it was before the script began workn.
nextupdate="$(($currentupdate + 1))" #inspo from: /media/daniella/ceb6a175-7104-43d8-8064-48e6ef72cd27/flic/init-new-build.sh

if [ "$latestupdate" -gt "$currentupdate" ]
   then
      echo "New update available!"
      echo "Core: Currently you have installed: Update $currentupdate ; But there's available: Update(s) $nextupdate to $latestupdate."
#loopmile="5" #inspo from /media/daniella/B/git/Gamlr/Gamlr/tools/list-construct-addons/get-c2-proj-addons.sh
until [[ "$currentupdate" = "$latestupdate" ]]
do
echo "Installing Update $nextupdate (Core)..."
cd ./updates
bash "$nextupdate.sh"
cd "$rocketlaunch_dir"
echo "$nextupdate" > lastupdate.txt
currentupdate="$(cat lastupdate.txt)" #update the variable
nextupdate="$(($currentupdate + 1))" #update the variable
#wait 1s
sleep 0.5s
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
nextupdate="$currentupdate" #no need to raise anymore after loop stopped. this isn't necessary, but here for cleanny purposes.

# knows if upper layers are present, and install their updates
          if [ -e ../../../soil ] || [ -e ../../../server ]
          then
             echo "- Upper layers are here. Detecting..."
# Server>
             if [ -f ../../../server/update.sh ];then
             echo "- Openning Floflis Server updates installer..."
             sudo chmod +x ../../../server/update.sh && cd ../../../server && bash ./update.sh
                cd "$rocketlaunch_dir"
fi
# <Server
# Soil>
             if [ -f ../../../soil/update.sh ];then
                echo "- Openning Floflis Soil updates installer..."
                sudo chmod +x ../../../soil/update.sh && cd ../../../soil && bash ./update.sh
                cd "$rocketlaunch_dir"
fi
# <Soil
# Grass>
             if [ -f ../../../grass/update.sh ];then
                echo "- Openning Floflis Grass updates installer..."
                sudo chmod +x ../../../grass/update.sh && cd ../../../grass && bash ./update.sh
                cd "$rocketlaunch_dir"
fi
# <Grass
# Base>
             if [ -f ../../../base/update.sh ];then
                echo "- Openning Floflis Base updates installer..."
                sudo chmod +x ../../../base/update.sh && cd ../../../base && bash ./update.sh
                cd "$rocketlaunch_dir"
fi
# <Base
# Home>
             if [ -f ../../../home/update.sh ];then
                echo "- Openning Floflis Home updates installer..."
                sudo chmod +x ../../.."$FLOPREFIX"home/update.sh && cd ../../../home && bash ./update.sh
                cd "$rocketlaunch_dir"
fi
# <Home
# Ultimate>
             if [ -f ../../../ultimate/update.sh ];then
                echo "- Openning Floflis Ultimate updates installer..."
                sudo chmod +x ../../../ultimate/update.sh && cd ../../../ultimate && bash ./update.sh
                cd "$rocketlaunch_dir"
fi
# <Ultimate
# Planetary>
             if [ -f ../../../planetary/update.sh ];then
                echo "- Openning Floflis Planetary updates installer..."
                sudo chmod +x ../../../planetary/update.sh && cd ../../../planetary && bash ./update.sh
                cd "$rocketlaunch_dir"
fi
# <Planetary
fi

# Finished updating each individual layer.
cd ../../..
if [ -e install.sh ]; then $maysudo bash install.sh;else cd dna;$maysudo bash install.sh;fi #detecter wether a local install or a system install
cd "$rocketlaunch_dir"
if [ "$currentupdate" = "$latestupdate" ];then echo "Core: Successfully updated from Update $pastupdate to $currentupdate!";fi
   else
      echo "No new update available, yet. Check again later."
      echo "Currently you have installed: Update $currentupdate (Core)."
fi
