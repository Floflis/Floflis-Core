#!/bin/bash

# Layer: Core

#. /usr/lib/floflis/./config
. "$FLOPREFIX"usr/lib/floflis/./config #expecting $FLOPREFIX has been successfuly imported from DNA's installer
#export FLOPREFIX
#fi
#export flofmach && export flofdistro && export flofarch && export osfullname && export osname && export osversion && export osbuild && export osbuildcodename && export updatepatch && export year && export layer && export nxtlayer && export distrobase && export user && export specialbuildattempt
# <---- load definitions & settings

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

if [ -e "$FLOPREFIX"tmp/cubicmode ]; then maysudo="";fi
if [[ "$flofmach" == "Termux" ]]; then maysudo="";fi

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
if [ -e "$FLOPREFIX"usr/lib/floflis/layers/dna ]
then
   echo "(✓) Floflis DNA is detected."
   echo "- Upgrading to Floflis Core..."
   if [ ! -e "$FLOPREFIX"1 ]; then
      echo "- Creating tree folder above root..."
      echo "- Creating "$FLOPREFIX"1 (tree) folder..."
      $maysudo mkdir "$FLOPREFIX"1
   fi
   echo "- Setting permissions on "$FLOPREFIX"1 (tree) folder..."
   $maysudo chmod -R a+rwX "$FLOPREFIX"1

   echo "Testing write permissions on tree folder..."
   echo "If it takes more than 30 seconds, please reboot your device and try again."
   echo "🤓 If u're nerd: root will be needed for applying chmod to folder. So, instead of being owned by root, tree folder will be writable by you as normal user."
   echo -n > "$FLOPREFIX"1/temp.txt
   # only use it while Floflis Central isn't yet done:
   echo -n > "$FLOPREFIX"1/temp2.txt

   if [ -e "$FLOPREFIX"1/temp2.txt ]
   then
      rm "$FLOPREFIX"1/temp.txt
      rm "$FLOPREFIX"1/temp2.txt
      
      if [ -e "$FLOPREFIX"usr/local/bin/*antiX* ]; then
         echo "- This is an antiX-based OS. Updating files..."
         $maysudo cp -f ./include/antiX/cli-installer "$FLOPREFIX"usr/local/bin/
         $maysudo cp -f ./include/antiX/antiX-cli-cc "$FLOPREFIX"usr/local/bin/
fi

#Fix Termux HTTPS issues that may arise from broken environment (probably bc of old Play Store -> F-Droid migration)
if [[ "$flofmach" == "Termux" ]]; then
export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib/ #from https://github.com/termux/termux-app/issues/2674#issuecomment-1077530046
ln -s -T /data/data/com.termux/files/usr/lib/openssl-1.1/libssl.so.1.1 /data/data/com.termux/files/usr/lib/libssl.so.1.1
ln -s -T /data/data/com.termux/files/usr/lib/openssl-1.1/libcrypto.so.1.1 /data/data/com.termux/files/usr/lib/libcrypto.so.1.1
#from https://github.com/termux/termux-app/issues/2674#issuecomment-1156736593 and https://unix.stackexchange.com/a/440908
fi

$maysudo apt update -y

if [[ "$flofmach" == "Termux" ]]; then
echo "Installing nu shell..."
apt install nushell -y #easiest to make it work, better than using a local binary file, unless plan to use IPFS instead/full package
apt install openssl -y
apt upgrade
fi

$maysudo apt --fix-broken install -y
$maysudo apt update -y

echo "Updating apt..."
$maysudo add-apt-repository universe -y
$maysudo apt update -y

$maysudo rm /var/cache/apt
$maysudo mkdir -p /var/cache/apt/archives/partial
$maysudo apt-get install git -y
$maysudo apt update -y
$maysudo apt --fix-broken install -y
$maysudo apt update -y

$maysudo apt-get install testdisk -y #Need to get 405 kB of archives. After this operation, 1.463 kB of additional disk space will be used.

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

echo "Installing rmv..."
cd include/rmv
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/rmv.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && $maysudo sh ./install.sh
#rm -f install.sh #use noah to exclude everything except .git
#rm -f README.md
#rm -f shit
#rm -f .gitmeta
cd "$SCRIPTPATH"

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
       
if [ "$flofarch" = "386" ]; then $maysudo cp -f include/jq/jq-linux-i386 "$FLOPREFIX"usr/bin/jq;fi
if [ "$flofarch" = "amd64" ]; then $maysudo cp -f include/jq/jq-linux-amd64 "$FLOPREFIX"usr/bin/jq;fi
#-
if [ "$flofarch" = "arm" ]; then $maysudo cp -f include/jq/jq-linux-armel "$FLOPREFIX"usr/bin/jq;fi
#-
if [ "$flofmach" = "Mac" ]; then
if [ "$flofarch" = "amd64" ]; then $maysudo cp -f include/jq/jq-macos-amd64 "$FLOPREFIX"usr/bin/jq;fi
if [ "$flofarch" = "arm64" ]; then $maysudo cp -f include/jq/jq-macos-arm64 "$FLOPREFIX"usr/bin/jq;fi
fi
#-
if [ "$flofmach" = "Linux" ]; then
if [ "$flofarch" = "arm64" ]; then $maysudo cp -f include/jq/jq-linux-arm64 "$FLOPREFIX"usr/bin/jq;fi
fi
#-
if [[ "$flofarch" = "armv7l" ]] || [[ "$flofarch" = "armv7hl" ]]; then
   $maysudo cp -f include/jq/jq-linux-armhf "$FLOPREFIX"usr/bin/jq
fi
#-
if [ "$flofarch" = "riscv64" ]; then $maysudo cp -f include/jq/jq-linux-riscv64 "$FLOPREFIX"usr/bin/jq;fi
#-
if [ -e "$FLOPREFIX"usr/bin/jq ]; then chmod +x "$FLOPREFIX"usr/bin/jq; fi
$maysudo apt install jq #ensure other systems can try to install it, via Internet
echo "Testing if jq works:"
jq

# Install IPFS:
      if [ "$flofarch" = "386" ]; then
         tar -xzf include/gipfs/include/IPFS/kubo_v0.18.1_linux-amd64.tar.gz
         sudo mv kubo/ipfs "$FLOPREFIX"usr/bin
         sudo rm -r kubo
         chmod +x "$FLOPREFIX"usr/bin/ipfs
         echo "Testing if IPFS works:"
         ipfs
fi
      if [ "$flofarch" = "amd64" ]; then
         tar -xzf include/gipfs/include/IPFS/kubo_v0.18.1_linux-amd64.tar.gz
         sudo mv kubo/ipfs "$FLOPREFIX"usr/bin
         sudo rm -r kubo
         chmod +x "$FLOPREFIX"usr/bin/ipfs
         echo "Testing if IPFS works:"
         ipfs
fi
# <---- future task: check against .cid file; floflis icons: icon for .cid files and file handler for comparing
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

# Install ethereal-multi:
cd include/ethereal-multi
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/ethereal-multi.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && $maysudo bash ./install.sh
#rm -f install.sh #use noah to exclude everything except .git
#rm -f README.md
#rm -f shit
#rm -f .gitmeta
cd "$SCRIPTPATH"

#      if [ "$flofarch" = "386" ]; then
#         tar -xzf include/IPFS/go-ipfs_v0.4.22_linux-386.tar.gz
#         rm -f go-ipfs/install.sh && rm -f go-ipfs/LICENSE && rm -f go-ipfs/README.md
#         $maysudo mv go-ipfs/ipfs "$FLOPREFIX"usr/bin
#         $maysudo rm -rf go-ipfs
#         chmod +x "$FLOPREFIX"usr/bin/ipfs
#         echo "Testing if IPFS works:"
#         ipfs
#fi
if [ "$flofarch" = "amd64" ]; then
   echo "Installing Cicada (Bash replacement written in Rust)..."
   $maysudo cp -f include/cicada/cicada-x86_64-unknown-linux-gnu-0.9.38 "$FLOPREFIX"usr/bin/cicada
fi
#-
if [ "$flofmach" = "Mac" ]; then
if [ "$flofarch" = "arm64" ]; then
   echo "Installing Cicada (Bash replacement written in Rust)..."
   $maysudo cp -f include/cicada/cicada-aarch64-apple-darwin-0.9.38 "$FLOPREFIX"usr/bin/cicada
fi
fi
#-
if [ "$flofmach" = "Linux" ]; then
if [ "$flofarch" = "arm64" ]; then
   echo "Installing Cicada (Bash replacement written in Rust)..."
   $maysudo cp -f include/cicada/cicada-aarch64-unknown-linux-gnu-0.9.38 "$FLOPREFIX"usr/bin/cicada
fi
fi
#-
if [ "$flofarch" = "armv7l" ]; then
   echo "Installing Cicada (Bash replacement written in Rust)..."
   $maysudo cp -f include/cicada/cicada-armv7-unknown-linux-gnueabihf-0.9.38 "$FLOPREFIX"usr/bin/cicada
fi
#-
if [ -e "$FLOPREFIX"usr/bin/cicada ]; then chmod +x "$FLOPREFIX"usr/bin/cicada; fi
#echo "Testing if cicada works:"
#cicada

#ethereal-2.7.4-linux-arm64.tar.gz
# <---- future task: check against .sha256 file; floflis icons: icon for .sha256 files and file handler for comparing

#- This will add about 39.8 MB of files:
#- If your device have enough space and you want to update it using Web3Updater, it'll need ethereal.
#- Large files like ethereal aren't suitable to an core device such as a router.
#- Want to install ethereal, to use Ethereum and ENS?
#- task: if Floflis ISO/Cubic, automatically install ethereal

echo "- Installing programs..."
$maysudo apt-get install aria2 dateutils

#echo "- Updating your Linux distro..."
#$maysudo apt-get update && $maysudo apt-get upgrade && $maysudo apt autoremove

#echo "- Upgrading your Linux distro..."
#$maysudo apt-get dist-upgrade && $maysudo apt-get clean

#echo "- Updating your Linux distro (again)..."
#$maysudo apt-get update && $maysudo apt-get upgrade

echo "Upgrading packages and distro packages..."
$maysudo apt update && $maysudo apt upgrade
$maysudo apt upgrade -y #from https://linuxhint.com/update_all_packages_ubuntu/
$maysudo apt-get autoremove
$maysudo apt-get autoclean
$maysudo apt dist-upgrade
$maysudo apt-get autoremove
$maysudo apt-get autoclean
$maysudo do-release-upgrade #from https://www.cyberciti.biz/faq/upgrade-ubuntu-20-04-lts-to-22-04-lts/
$maysudo apt-get autoremove
$maysudo apt-get autoclean
#-from https://elias.praciano.com/2014/08/apt-get-quais-as-diferencas-entre-autoremove-autoclean-e-clean/
$maysudo apt --fix-broken install

#rmv previous kernel
#Cleanup old kernel versions
#Find a list of all currently installed kernel versions. An easy way to do this is to list the config files in the /boot folder:
#-
#ls -r /boot/config-*
#-
#This will provide a list. For each instance make a note of that version number. Then, list all linux packages:
#-
#dpkg --list | grep -i "linux-"
#-
#Then purge all the packages with old version numbers. IconsPage/warning.png Do not purge packages with the most current kernel number:
#-
#apt-get purge <packages>
#-
#For example:
#-
#apt-get purge linux-headers-5.15.0-43 linux-headers-5.15.0-43-generic linux-image-5.15.0-43-generic linux-modules-5.15.0-43-generic linux-modules-extra-5.15.0-43-generic
$maysudo apt-get purge linux-headers-6.2.0-27 linux-headers-6.2.0-27-generic linux-image-6.2.0-27-generic linux-modules-6.2.0-27-generic linux-modules-extra-6.2.0-27-generic

echo "- Installing the broken packages, efibootmgr and grub..."
$maysudo apt-get install efibootmgr
if [ "$flofarch" = "amd64" ]; then $maysudo apt-get install grub-efi-amd64-bin grub-efi-amd64-signed;fi

if [ ! -e "$FLOPREFIX"1/config ]; then echo "Creating settings folder...";mkdir "$FLOPREFIX"1/config; fi

#$maysudo cat > "$FLOPREFIX"1/config/dat.json << ENDOFFILE
#{"type":"config/os","url":{},"lang":"en-us","title":"Floflis Settings - 
#ENDOFFILE

#       echo "$()" > "$FLOPREFIX"1/config/dat.json

       #$maysudo cat > "$FLOPREFIX"1/config/dat.json << ENDOFFILE
#","user":" 
#ENDOFFILE

       #$(whoami) >> "$FLOPREFIX"1/config/dat.json

       #$maysudo cat > "$FLOPREFIX"1/config/dat.json << ENDOFFILE
#"}
#ENDOFFILE

if [ ! -e "$FLOPREFIX"1/Floflis ]; then echo "Creating sys folder...";mkdir "$FLOPREFIX"1/Floflis; fi
if [ ! -e "$FLOPREFIX"1/Floflis/system ]; then mkdir "$FLOPREFIX"1/Floflis/system;echo ""; fi
    #tar xfvz 
fi

   # Extracting data to sys folder...
   # Setting permissions on "$FLOPREFIX"1/Floflis folder... chown -R root:root "$FLOPREFIX"1/Floflis chmod 700 "$FLOPREFIX"1/Floflis
   # Creating Open Badges folder... "$FLOPREFIX"1/badges
   # badge for pneer since 06
   # file with claimed badges, send it to Floflis (and store its date), tell when badges are available for download
   # "$FLOPREFIX"1/apps "$FLOPREFIX"1/appsclassic "$FLOPREFIX"1/games "$FLOPREFIX"1/gamesclassic
   # Creating Apps folder... "$FLOPREFIX"1/Apps
   # Installing apps...
   if [ ! -e "$FLOPREFIX"1/programs ]; then echo "Creating folder for classic apps (/programs)...";$maysudo mkdir "$FLOPREFIX"1/programs; fi
   if [ ! -e "$FLOPREFIX"1/libraries ]; then echo "Creating /libraries...";$maysudo mkdir "$FLOPREFIX"1/libraries; fi
   if [ ! -e "$FLOPREFIX"1/libraries/replic ]; then echo "Creating /libraries/replic...";$maysudo mkdir "$FLOPREFIX"1/libraries/replic; fi
   echo "- Setting permissions on /libraries/replic..."
   $maysudo chmod -R a+rwX "$FLOPREFIX"1/libraries/replic/
   if [ ! -f "$FLOPREFIX"1/Z-root ]; then echo "- Creating root folder inside tree...";$maysudo ln -s ../ Z-root; fi
   # Installing classic apps...
   # chmod cj
   # Creating folders for games and HTML5 files
   # Creating Games folder...
   # "$FLOPREFIX"1/Games
   # Creating HTML5 folder...
   # "$FLOPREFIX"1/html5
   # Installing HTML5 files...
   if [ ! -e "$FLOPREFIX"1/src ]; then echo "Installing "$FLOPREFIX"1/src";$maysudo mkdir "$FLOPREFIX"1/src; fi
   #echo "Installing "$FLOPREFIX"1/personal/data/issues"
   #$maysudo mkdir "$FLOPREFIX"1/personal
   #$maysudo mkdir "$FLOPREFIX"1/personal/data
   #$maysudo mkdir "$FLOPREFIX"1/personal/data/issues
   if [ ! -e "$FLOPREFIX"1/personal ]; then echo "- Creating "$FLOPREFIX"1/personal...";$maysudo mkdir "$FLOPREFIX"1/personal; fi
   if [ ! -e "$FLOPREFIX"1/personal/data ]; then echo "- Creating "$FLOPREFIX"1/personal/data...";$maysudo mkdir "$FLOPREFIX"1/personal/data; fi
   
   #task: run this cmd only if detecting ubuntu+chroot
   #removed. is this cmd an requirement? for now, lets experiment with an init script.
   #$maysudo echo "$(cat "$FLOPREFIX"usr/lib/floflis/layers/core/preseed)" >> /preseed/ubuntu.seed && $maysudo rm -f "$FLOPREFIX"usr/lib/floflis/layers/core/preseed
   #$maysudo cp -f "$FLOPREFIX"usr/lib/floflis/layers/core/postinstall / && $maysudo rm -f "$FLOPREFIX"usr/lib/floflis/layers/core/postinstall
   
   echo "- Installing Floflis Core as init program..."
   $maysudo echo "$(cat "$FLOPREFIX"usr/lib/floflis/layers/core/flo-init)" >> /etc/init.d/flo-init && $maysudo rm -f "$FLOPREFIX"usr/lib/floflis/layers/core/flo-init
   $maysudo chmod +x /etc/init.d/flo-init
   $maysudo update-rc.d flo-init defaults
   $maysudo update-rc.d flo-init enable
   $maysudo systemctl enable flo-init
   $maysudo systemd enable flo-init
   
   echo "- Installing Floflis' first boot script..."
   $maysudo cp -f "$FLOPREFIX"usr/lib/floflis/layers/core/firstboot /etc/init.d && $maysudo rm -f "$FLOPREFIX"usr/lib/floflis/layers/core/firstboot
   $maysudo chmod +x /etc/init.d/firstboot
   $maysudo update-rc.d firstboot defaults
   $maysudo update-rc.d firstboot enable
   $maysudo systemctl enable firstboot
   $maysudo systemd enable firstboot

   echo "- Installing Floflis Central CLI..."
   echo "[1/2] Central's Dependencies..."
   if [ -e "$FLOPREFIX"usr/lib/shell ];then $maysudo mkdir "$FLOPREFIX"usr/lib/shell;fi
   $maysudo mv "$FLOPREFIX"usr/lib/floflis/layers/core/include/antiX/libs/. "$FLOPREFIX"usr/lib/shell
   #$maysudo mv -r "$FLOPREFIX"usr/lib/floflis/layers/core/include/antiX"$FLOPREFIX"usr-share/. "$FLOPREFIX"usr/share/antiX-cli-cc/
   if [ -e "$FLOPREFIX"usr/share/central ];then $maysudo mkdir "$FLOPREFIX"usr/share/central;fi
   $maysudo rsync -av "$FLOPREFIX"usr/lib/floflis/layers/core/include/antiX"$FLOPREFIX"usr-share/. "$FLOPREFIX"usr/share/central
   #-
   echo "[2/2] Central's Executable..."
   $maysudo mv "$FLOPREFIX"usr/lib/floflis/layers/core/central "$FLOPREFIX"usr/bin
   $maysudo chmod 755 "$FLOPREFIX"usr/bin/central
   
   echo "- Cleanning install, saving settings..."
   $maysudo apt-get autoremove
   $maysudo apt-get autoclean
   $maysudo apt --fix-broken install
   $maysudo rm "$FLOPREFIX"usr/lib/floflis/layers/core/install.sh
   $maysudo sed -i 's/core/soil/g' "$FLOPREFIX"usr/lib/floflis/config && $maysudo sed -i 's/dna/core/g' "$FLOPREFIX"usr/lib/floflis/config
   
   echo "- Saving settings as JSON..."
   cat > "$FLOPREFIX"1/Floflis/system/os.json << ENDOFFILE
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

if [[ "$flofmach" == "Termux" ]]; then
chmod +x firstboot
sh ./firstboot
bash firstlogon.sh
#cd "$SCRIPTPATH"
fi

   contents="$(jq ".name = \"$osname\"" "$FLOPREFIX"1/Floflis/system/os.json)" && \
   echo "${contents}" > "$FLOPREFIX"1/Floflis/system/os.json
   contents="$(jq ".version = \"$osversion\"" "$FLOPREFIX"1/Floflis/system/os.json)" && \
   echo "${contents}" > "$FLOPREFIX"1/Floflis/system/os.json
   contents="$(jq ".build = \"$osbuild\"" "$FLOPREFIX"1/Floflis/system/os.json)" && \
   echo "${contents}" > "$FLOPREFIX"1/Floflis/system/os.json
   contents="$(jq ".year = \"$year\"" "$FLOPREFIX"1/Floflis/system/os.json)" && \
   echo "${contents}" > "$FLOPREFIX"1/Floflis/system/os.json
   contents="$(jq ".distrobase = \"$distrobase\"" "$FLOPREFIX"1/Floflis/system/os.json)" && \
   echo "${contents}" > "$FLOPREFIX"1/Floflis/system/os.json
   
   contents="$(jq ".layer = \"$layer\"" "$FLOPREFIX"1/Floflis/system/os.json)" && \
   echo "${contents}" > "$FLOPREFIX"1/Floflis/system/os.json
   contents="$(jq ".nxtlayer = \"$nxtlayer\"" "$FLOPREFIX"1/Floflis/system/os.json)" && \
   echo "${contents}" > "$FLOPREFIX"1/Floflis/system/os.json
   echo "(✓) Floflis DNA has been upgraded to Floflis Core."
else
   echo "(X) Floflis DNA isn't found. Please install Floflis DNA before installing Floflis Core."
   echo ""
   echo "Floflis DNA at IPFS:"
   echo "Normal version: https://gateway.pinata.cloud/ipfs/QmdweQW6FUjvMHCKSz5h7WpMifgzFvh2SFm9T4hiZ6rY4h"
   echo "Lite version: https://gateway.pinata.cloud/ipfs/QmXSiq2atUQeisoiV3PDisNP4LecBCNLv6p6nymvn6JyRL"
fi
