#!/bin/bash

rocketlaunch_dir=`pwd` #from https://unix.stackexchange.com/a/52919/470623

cd ./updates

#latestbuild=$(find -maxdepth 1 -name '*.sh' | sort -t_ -nk2,2 | tail -n1)
#diruse="${latestbuild##*.sh}"

lastblockpath=$(find -maxdepth 1 -name '*.sh' | sort -t_ -nk2,2 | tail -n1)
tmp="${lastblockpath##*/}" # gives 2.sh
lastblock="${tmp%.*}"      # gives 2
# inspo for above, from: /media/daniella/B/git/Plasmmer/Plasmmer/GLUE/SharedChain/commonchain.sh

echo "DEBUG latestbuild: $latestbuild"
echo "DEBUG diruse: $diruse"

cd "$rocketlaunch_dir"

if [ "$(cinnamon --version)" = "Cinnamon $(cat inspo.txt)" ];
then
   echo ""
#   sudo cp -f js/ui/panel.js /usr/share/cinnamon/js/ui/
fi

if [ "$(cinnamon --version)" = "Cinnamon 5.8.4" ];
then
   echo ""
#   sudo cp -f 5.8.4/js/ui/panel.js /usr/share/cinnamon/js/ui/
fi

if [ "$(cinnamon --version)" = "Cinnamon $(cat currentversion.txt)" ] || [ "$(cinnamon --version)" = "Cinnamon 5.8.4" ];
then
   echo ""
else
   echo ""
#   echo "Expected/supported version: Cinnamon $(cat currentversion.txt)"
#   echo "Your current version: $(cinnamon --version)"
fi
