#!/bin/bash

# Layer: Core

# load definitions & settings
. /usr/lib/floflis/./config

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

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

ok="Ok."
invalid="Please enter a valid input"

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
   if [ ! -e /1 ]; then
      echo "- Creating tree folder above root..."
      echo "- Creating /1 (tree) folder..."
      $maysudo mkdir /1
   fi
   echo "- Setting permissions on /1 (tree) folder..."
   $maysudo chmod -R a+rwX /1

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
      
      if [ -e /usr/local/bin/*antiX* ]; then
         echo "- This is a antiX-based OS. Updating files..."
         $maysudo cp -f ./include/antiX/cli-installer /usr/local/bin/
         $maysudo cp -f ./include/antiX/antiX-cli-cc /usr/local/bin/
fi

echo "Updating apt..."
$maysudo add-apt-repository universe -y
$maysudo apt-get update -y

echo "Installing 01 VCS..."
cd include/01
if [ ! -e .git ]; then git clone --no-checkout https://github.com/01VCS/01.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && $maysudo sh ./install.sh
#rm -f install.sh #use noah to exclude everything except .git
#rm -f 01
#rm -f git
#rm -f README.md
#rm -f recipe.json
#rm -f Tasks.txt
#rm -f .gitignore
#rm -f .gitmeta
cd "$SCRIPTPATH"
echo "Testing if 01 works:"
01

echo "Installing filepeace (includes webpresent, folderstamp, etc)..."
cd include/filepeace
if [ ! -e .git ]; then git clone --no-checkout https://github.com/FilePeace/filepeace.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && $maysudo sh ./install.sh
cd "$SCRIPTPATH"
echo "Testing if filepeace works:"
filepeace

# Install jq:
   echo "Installing jq..."
       
      if [ "$flofarch" = "386" ]; then
#         tar -xzf include/jq/jq-linux32.tar.gz
#         $maysudo mv jq /usr/bin
         $maysudo cp -f include/jq/jq-linux32 /usr/bin/jq
         chmod +x /usr/bin/jq
         echo "Testing if jq works:"
         jq
fi
      if [ "$flofarch" = "amd64" ]; then
#         tar -xzf include/jq/jq-linux64.tar.gz
#         $maysudo mv jq /usr/bin
         $maysudo cp -f include/jq/jq-linux64 /usr/bin/jq
         chmod +x /usr/bin/jq
         echo "Testing if jq works:"
         jq
fi

echo "Installing gipfs (includes IPFS, ipget, etc)..."
cd include/gipfs
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Web3HQ/gipfs.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && $maysudo sh ./install.sh
cd "$SCRIPTPATH"
echo "Testing if gipfs works:"
gipfs

echo "Installing online..."
cd include/Tools/online
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/online.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && $maysudo sh ./install.sh
#rm -f install.sh #use noah to exclude everything except .git
#rm -f README.txt
#rm -f online
#rm -f README.md
#rm -f 'SRC At ETH💎💌.txt'
cd "$SCRIPTPATH"

echo "Installing mlq..."
cd include/Tools/mlq
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/mlq.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && $maysudo sh ./install.sh
#rm -f install.sh #use noah to exclude everything except .git
#rm -f README.md
#rm -f mlq
#rm -f dependencies.txt
#rm -f mlq-parser.sh
#rm -f mlq-parser_worker.sh
#rm -f sample.html
#rm -f Tasks.txt
#rm -f .gitmeta
#rm -f 'SRC At ETH💎💌.txt'
cd "$SCRIPTPATH"

echo "Installing Sh it..."
cd include/Tools/shexec
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/shit.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && $maysudo sh ./install.sh
#rm -f install.sh #use noah to exclude everything except .git
#rm -f README.md
#rm -f shit
#rm -f .gitmeta
sudo apt install curl
cd "$SCRIPTPATH"

# Install ethereal:

#      if [ "$flofarch" = "386" ]; then
#         tar -xzf include/IPFS/go-ipfs_v0.4.22_linux-386.tar.gz
#         rm -f go-ipfs/install.sh && rm -f go-ipfs/LICENSE && rm -f go-ipfs/README.md
#         $maysudo mv go-ipfs/ipfs /usr/bin
#         $maysudo rm -rf go-ipfs
#         chmod +x /usr/bin/ipfs
#         echo "Testing if IPFS works:"
#         ipfs
#fi
      if [ "$flofarch" = "amd64" ]; then
         echo "Installing ethereal..."
         tar -xzf include/ethereal/ethereal-2.8.5-linux-amd64.tar.gz
         $maysudo mv ethereal /usr/bin
         chmod +x /usr/bin/ethereal
         echo "Testing if ethereal works:"
         ethereal
fi
#ethereal-2.7.4-linux-arm64.tar.gz
# <---- future task: check against .sha256 file; floflis icons: icon for .sha256 files and file handler for comparing

#- This will add about 39.8 MB of files:
#- If your device have enough space and you want to update it using Web3Updater, it'll need ethereal.
#- Large files like ethereal aren't suitable to an core device such as a router.
#- Want to install ethereal, to use Ethereum and ENS?
#- task: if Floflis ISO/Cubic, automatically install ethereal

echo "- Installing programs..."
$maysudo apt-get install aria2

#echo "- Updating your Linux distro..."
#$maysudo apt-get update && $maysudo apt-get upgrade && $maysudo apt autoremove

#echo "- Upgrading your Linux distro..."
#$maysudo apt-get dist-upgrade && $maysudo apt-get clean

#echo "- Updating your Linux distro (again)..."
#$maysudo apt-get update && $maysudo apt-get upgrade

echo "Upgrading packages and distro packages..."
$maysudo apt upgrade
$maysudo apt dist-upgrade

echo "- Installing the broken packages, efibootmgr and grub..."
$maysudo apt-get install efibootmgr grub-efi-amd64-bin grub-efi-amd64-signed

       if [ ! -e /1/config ]; then echo "Creating settings folder...";mkdir /1/config; fi

#$maysudo cat > /1/config/dat.json << ENDOFFILE
#{"type":"config/os","url":{},"lang":"en-us","title":"Floflis Settings - 
#ENDOFFILE

#       echo "$()" > /1/config/dat.json

       #$maysudo cat > /1/config/dat.json << ENDOFFILE
#","user":" 
#ENDOFFILE

       #$(whoami) >> /1/config/dat.json

       #$maysudo cat > /1/config/dat.json << ENDOFFILE
#"}
#ENDOFFILE

    if [ ! -e /1/Floflis ]; then echo "Creating sys folder...";mkdir /1/Floflis; fi
    if [ ! -e /1/Floflis/system ]; then mkdir /1/Floflis/system;echo ""; fi
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
   if [ ! -e /1/programs ]; then echo "Creating folder for classic apps (/programs)...";$maysudo mkdir /1/programs; fi
   if [ ! -e /1/libraries ]; then echo "Creating /libraries...";$maysudo mkdir /1/libraries; fi
   if [ ! -e /1/libraries/replic ]; then echo "Creating /libraries/replic...";$maysudo mkdir /1/libraries/replic; fi
   echo "- Setting permissions on /libraries/replic..."
   $maysudo chmod -R a+rwX /1/libraries/replic/
   if [ ! -f /1/Z-root ]; then echo "- Creating root folder inside tree...";$maysudo ln -s ../ Z-root; fi
   # Installing classic apps...
   # chmod cj
   # Creating folders for games and HTML5 files
   # Creating Games folder...
   # /1/Games
   # Creating HTML5 folder...
   # /1/html5
   # Installing HTML5 files...
   if [ ! -e /1/src ]; then echo "Installing /1/src";$maysudo mkdir /1/src; fi
   #echo "Installing /1/personal/data/issues"
   #$maysudo mkdir /1/personal
   #$maysudo mkdir /1/personal/data
   #$maysudo mkdir /1/personal/data/issues
   if [ ! -e /1/personal ]; then echo "- Creating /1/personal...";$maysudo mkdir /1/personal; fi
   if [ ! -e /1/personal/data ]; then echo "- Creating /1/personal/data...";$maysudo mkdir /1/personal/data; fi
   
   #task: run this cmd only if detecting ubuntu+chroot
   #removed. is this cmd an requirement? for now, lets experiment with an init script.
   #$maysudo echo "$(cat /usr/lib/floflis/layers/core/preseed)" >> /preseed/ubuntu.seed && $maysudo rm -f /usr/lib/floflis/layers/core/preseed
   #$maysudo cp -f /usr/lib/floflis/layers/core/postinstall / && $maysudo rm -f /usr/lib/floflis/layers/core/postinstall
   
   echo "- Installing Floflis Core as init program..."
   $maysudo echo "$(cat /usr/lib/floflis/layers/core/flo-init)" >> /etc/init.d/flo-init && $maysudo rm -f /usr/lib/floflis/layers/core/flo-init
   $maysudo chmod +x /etc/init.d/flo-init
   $maysudo update-rc.d flo-init defaults
   $maysudo update-rc.d flo-init enable
   $maysudo systemctl enable flo-init
   $maysudo systemd enable flo-init
   
   echo "- Installing Floflis' first boot script..."
   $maysudo cp -f /usr/lib/floflis/layers/core/firstboot /etc/init.d && $maysudo rm -f /usr/lib/floflis/layers/core/firstboot
   $maysudo chmod +x /etc/init.d/firstboot
   $maysudo update-rc.d firstboot defaults
   $maysudo update-rc.d firstboot enable
   $maysudo systemctl enable firstboot
   $maysudo systemd enable firstboot

   echo "- Installing Floflis Central..."
   $maysudo mv /usr/lib/floflis/layers/core/central /usr/bin
   $maysudo chmod 755 /usr/bin/central
   
   echo "- Cleanning install, saving settings..."
   $maysudo rm /usr/lib/floflis/layers/core/install.sh
   $maysudo sed -i 's/core/soil/g' /usr/lib/floflis/config && $maysudo sed -i 's/dna/core/g' /usr/lib/floflis/config
   
   echo "- Saving settings as JSON..."
   cat > /1/Floflis/system/os.json << ENDOFFILE
{
"name":"",
"version": "",
"build":"",
"year":"",
"layer":"",
"nxtlayer":"",
"distrobase":""
}
ENDOFFILE

   . /usr/lib/floflis/./config

   contents="$(jq ".name = \"$osname\"" /1/Floflis/system/os.json)" && \
   echo "${contents}" > /1/Floflis/system/os.json
   contents="$(jq ".version = \"$osversion\"" /1/Floflis/system/os.json)" && \
   echo "${contents}" > /1/Floflis/system/os.json
   contents="$(jq ".build = \"$osbuild\"" /1/Floflis/system/os.json)" && \
   echo "${contents}" > /1/Floflis/system/os.json
   contents="$(jq ".year = \"$year\"" /1/Floflis/system/os.json)" && \
   echo "${contents}" > /1/Floflis/system/os.json
   contents="$(jq ".distrobase = \"$distrobase\"" /1/Floflis/system/os.json)" && \
   echo "${contents}" > /1/Floflis/system/os.json
   
   contents="$(jq ".layer = \"$layer\"" /1/Floflis/system/os.json)" && \
   echo "${contents}" > /1/Floflis/system/os.json
   contents="$(jq ".nxtlayer = \"$nxtlayer\"" /1/Floflis/system/os.json)" && \
   echo "${contents}" > /1/Floflis/system/os.json
   echo "(✓) Floflis DNA has been upgraded to Floflis Core."
else
   echo "(X) Floflis DNA isn't found. Please install Floflis DNA before installing Floflis Core."
   echo ""
   echo "Floflis DNA at IPFS:"
   echo "Normal version: https://gateway.pinata.cloud/ipfs/QmdweQW6FUjvMHCKSz5h7WpMifgzFvh2SFm9T4hiZ6rY4h"
   echo "Lite version: https://gateway.pinata.cloud/ipfs/QmXSiq2atUQeisoiV3PDisNP4LecBCNLv6p6nymvn6JyRL"
fi
