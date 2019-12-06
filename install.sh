#!/bin/bash

# load definitions & settings
source /usr/lib/floflis/config
# it doesn't works yet. need to do it manually here:

unameOutM="$(uname -m)"
case "${unameOutM}" in
    i286)   flofarch="286";;
    i386)   flofarch="386";;
    i686)   flofarch="386";;
    x86_64) flofarch="amd64";;
    arm)    dpkg --print-flofarch | grep -q "arm64" && flofarch="arm64" || flofarch="arm";;
    riscv64) flofarch="riscv64"
esac

cat << "EOF"
-. .-.   .-. .-.   .-. .-.   .
  \   \ /   \   \ /   \   \ /
 / \   \   / \   \   / \   \
~   `-~ `-`   `-~ `-`   `-~ `-
  _            _           
 |_  |   _   _|_  |  o   _ 
 |   |  (_)   |   |  |  _> 
                           
  ___               _            _   _             
 |_ _|  _ _    ___ | |_   __ _  | | | |  ___   _ _ 
  | |  | ' \  (_-< |  _| / _` | | | | | / -_) | '_|
 |___| |_||_| /__/  \__| \__,_| |_| |_| \___| |_|  

                  for Floflis Core
EOF
echo "- Detecting if Floflis DNA is installed..."
if [ -e /usr/lib/floflis/layers/dna ]
then
   echo "(✓) Floflis DNA is detected."
   echo "- Upgrading to Floflis Core..."
   echo "- Creating tree folder above root..."
   echo "- Creating /1 (tree) folder..."
   sudo mkdir /1
   echo "- Setting permissions on /1 (tree) folder..."
   sudo chmod -R a+rwX /1

   echo "Testing write permissions on tree folder..."
   echo "If it takes more than 30 seconds, please reboot your device and try again."
   echo "🤓 If u're nerd: root will be needed for applying chmod to folder. So, instead of being owned by root, tree folder will be writable by you as normal user."
   echo -n > /1/temp.txt
   # only use it while Floflis Central isn't yet done:
   echo -n > /1/temp2.txt

   if [ -e /1/temp2.txt ]
   then
      rm /1/temp.txt
      rm /1/temp2.txt
       
      if [ "$flofarch" = "386" ]; then
         tar -xzf include/jq/jq-linux32.tar.gz
         sudo mv jq /usr/bin
         chmod +x /usr/bin/jq
         echo "Testing if jq works:"
         jq
fi
      if [ "$flofarch" = "amd64" ]; then
         tar -xzf include/jq/jq-linux64.tar.gz
         sudo mv jq /usr/bin
         chmod +x /usr/bin/jq
         echo "Testing if jq works:"
         jq
fi

       echo "Creating settings folder..."
       mkdir /1/config

       echo "Getting and storing username  (not available yet)..."
       #sudo cat > /1/config/dat.json << ENDOFFILE
       #{"type":"config/os","url":{},"lang":"en-us","title":"Floflis Settings - $whoami","user":" $whoami"}
       #ENDOFFILE

       #sudo cat > /1/config/dat.json << ENDOFFILE
#{"type":"config/os","url":{},"lang":"en-us","title":"Floflis Settings - 
#ENDOFFILE

#       echo "$()" > /1/config/dat.json

       #sudo cat > /1/config/dat.json << ENDOFFILE
#","user":" 
#ENDOFFILE

       #$(whoami) >> /1/config/dat.json

       #sudo cat > /1/config/dat.json << ENDOFFILE
#"}
#ENDOFFILE

    #echo "Creating sys folder..."
    #mkdir /1/Floflis
    #echo ""
    #tar xfvz 
fi

   # Extracting data to sys folder...
   # Setting permissions on /1/Floflis folder... chown -R root:root /1/Floflis chmod 700 /1/Floflis
   # Creating Open Badges folder... /1/badges
   # badge for pneer since 06
   # file with claimed badges, send it to Floflis (and store its date), tell when badges are available for download
   # /1/apps /1/appsclassic /1/games /1/gamesclassic
   # Creating Apps folder... /1/Apps
   # Installing apps...
   echo "Creating folder for classic apps (/programs)..."
   sudo mkdir /1/programs
   echo "Creating /libraries..."
   sudo mkdir /1/libraries
   echo "Creating /libraries/replic..."
   sudo mkdir /1/libraries/replic
   echo "- Setting permissions on /libraries/replic..."
   sudo chmod -R a+rwX /1/libraries/replic/
   echo "- Creating root folder inside tree..."
   sudo ln -s / /1/Z-root
   # Installing classic apps...
   # chmod cj
   # Creating folders for games and HTML5 files
   # Creating Games folder...
   # /1/Games
   # Creating HTML5 folder...
   # /1/html5
   # Installing HTML5 files...
   echo "Installing /1/src"
   sudo mkdir /1/src
   
echo "- Installing Floflis Core as init program..."
sudo echo "$(cat /usr/lib/floflis/layers/core/flo-init)" >> /etc/init.d/flo-init && sudo rm -f /usr/lib/floflis/layers/core/flo-init
sudo chmod 755 /etc/init.d/flo-init && sudo update-rc.d flo-init defaults

   echo "- Cleanning install, saving settings..."
   sudo rm /usr/lib/floflis/layers/core/install.sh
   sudo sed -i 's/dna/core/g' /usr/lib/floflis/config
   echo "(✓) Floflis DNA has been upgraded to Floflis Core."
else
   echo "(X) Floflis DNA isn't found. Please install Floflis DNA before installing Floflis Core."
   echo ""
   echo "Floflis DNA at IPFS:"
   echo "Normal version: https://gateway.pinata.cloud/ipfs/QmdweQW6FUjvMHCKSz5h7WpMifgzFvh2SFm9T4hiZ6rY4h"
   echo "Lite version: https://gateway.pinata.cloud/ipfs/QmXSiq2atUQeisoiV3PDisNP4LecBCNLv6p6nymvn6JyRL"
fi
