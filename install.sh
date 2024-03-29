#!/bin/bash

# Layer: Core

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

$maysudo=""

if [ "$is_root" = "false" ]
   then
      $maysudo="sudo"
   else
      $maysudo=""
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
   echo "- Creating tree folder above root..."
   echo "- Creating /1 (tree) folder..."
   $maysudo mkdir /1
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

# Install jq:

   echo "Installing jq..."
       
      if [ "$flofarch" = "386" ]; then
         tar -xzf include/jq/jq-linux32.tar.gz
         $maysudo mv jq /usr/bin
         chmod +x /usr/bin/jq
         echo "Testing if jq works:"
         jq
fi
      if [ "$flofarch" = "amd64" ]; then
         tar -xzf include/jq/jq-linux64.tar.gz
         $maysudo mv jq /usr/bin
         chmod +x /usr/bin/jq
         echo "Testing if jq works:"
         jq
fi

# Install IPFS:

   echo "Installing IPFS..."

      if [ "$flofarch" = "386" ]; then
         tar -xzf include/IPFS/go-ipfs_v0.4.22_linux-386.tar.gz
         rm -f go-ipfs/install.sh && rm -f go-ipfs/LICENSE && rm -f go-ipfs/README.md
         $maysudo mv go-ipfs/ipfs /usr/bin
         $maysudo rm -rf go-ipfs
         chmod +x /usr/bin/ipfs
         echo "Testing if IPFS works:"
         ipfs
fi
      if [ "$flofarch" = "amd64" ]; then
         tar -xzf include/IPFS/go-ipfs_v0.4.22_linux-amd64.tar.gz
         rm -f go-ipfs/install.sh && rm -f go-ipfs/LICENSE && rm -f go-ipfs/README.md
         $maysudo mv go-ipfs/ipfs /usr/bin
         $maysudo rm -rf go-ipfs
         chmod +x /usr/bin/ipfs
         echo "Testing if IPFS works:"
         ipfs
fi

$maysudo cat > /usr/bin/ipfsdaemon << ENDOFFILE
#!/bin/bash

ipfs daemon
ENDOFFILE

$maysudo chmod +x /usr/bin/ipfsdaemon

echo "Updating apt..."
$maysudo add-apt-repository universe -y
$maysudo apt-get update -y

echo "- Installing programs..."
$maysudo apt-get install aria2

# Install git:

echo "git is a need also for downloading updates. It is 6,3MB to download and 34.9 MB installed."
echo "Do you want to install git? [Y/n]"
read insgit
case $insgit in
   [nN])
      echo "${ok}"
      break ;;
   [yY])
      echo "Installing git..."
      $maysudo apt-get install git -y
      break ;;
   *)
      echo "${invalid}" ;;
esac

echo "- Updating your Linux distro..."
$maysudo apt-get update && $maysudo apt-get upgrade && $maysudo apt autoremove

echo "- Upgrading your Linux distro..."
$maysudo apt-get dist-upgrade && $maysudo apt-get clean

echo "- Updating your Linux distro (again)..."
$maysudo apt-get update && $maysudo apt-get upgrade

echo "- Installing the broken packages, efibootmgr and grub..."
$maysudo apt-get install efibootmgr grub-efi-amd64-bin grub-efi-amd64-signed

       echo "Creating settings folder..."
       mkdir /1/config

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
   $maysudo mkdir /1/programs
   echo "Creating /libraries..."
   $maysudo mkdir /1/libraries
   echo "Creating /libraries/replic..."
   $maysudo mkdir /1/libraries/replic
   echo "- Setting permissions on /libraries/replic..."
   $maysudo chmod -R a+rwX /1/libraries/replic/
   echo "- Creating root folder inside tree..."
   $maysudo ln -s / /1/Z-root
   # Installing classic apps...
   # chmod cj
   # Creating folders for games and HTML5 files
   # Creating Games folder...
   # /1/Games
   # Creating HTML5 folder...
   # /1/html5
   # Installing HTML5 files...
   echo "Installing /1/src"
   $maysudo mkdir /1/src
   
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
   
   #echo "- Installing Floflis' first boot script..."
   #$maysudo cp -f /usr/lib/floflis/layers/core/firstboot /etc/init.d && $maysudo rm -f /usr/lib/floflis/layers/core/firstboot
   #$maysudo chmod +x /etc/init.d/firstboot
   #$maysudo update-rc.d firstboot defaults
   #$maysudo update-rc.d firstboot enable
   #$maysudo systemctl enable firstboot
   #$maysudo systemd enable firstboot

   echo "- Installing Floflis Central..."
   $maysudo mv /usr/lib/floflis/layers/core/floflis-central /usr/bin
   $maysudo chmod 755 /usr/bin/floflis-central

   echo "- Cleanning install, saving settings..."
   $maysudo rm /usr/lib/floflis/layers/core/install.sh
   $maysudo sed -i 's/core/soil/g' /usr/lib/floflis/config && $maysudo sed -i 's/dna/core/g' /usr/lib/floflis/config
   echo "(✓) Floflis DNA has been upgraded to Floflis Core."
else
   echo "(X) Floflis DNA isn't found. Please install Floflis DNA before installing Floflis Core."
   echo ""
   echo "Floflis DNA at IPFS:"
   echo "Normal version: https://gateway.pinata.cloud/ipfs/QmdweQW6FUjvMHCKSz5h7WpMifgzFvh2SFm9T4hiZ6rY4h"
   echo "Lite version: https://gateway.pinata.cloud/ipfs/QmXSiq2atUQeisoiV3PDisNP4LecBCNLv6p6nymvn6JyRL"
fi
