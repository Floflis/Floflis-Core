#!/bin/bash

# load definitions & settings ---->
if [[ $(echo $PREFIX | grep -o "com.termux") == "com.termux" ]];
then
. /data/data/com.termux/files/usr/lib/floflis/./config
else
. /usr/lib/floflis/./config
export FLOPREFIX
fi
export flofmach && export flofdistro && export flofarch && export osfullname && export osname && export osversion && export osbuild && export osbuildcodename && export updatepatch && export year && export layer && export nxtlayer && export distrobase && export user && export specialbuildattempt
# <---- load definitions & settings

flouser=$(logname) # considers as main user, the first logged user after first boot 💃
export flouser

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

                  Welcome to Floflis!
EOF

# Core>
   if [ -e "$FLOPREFIX"usr/lib/floflis/layers/dna/floflis ]
   then
      if [ -e "$FLOPREFIX"usr/lib/floflis/layers/core ]
      then
         echo "Getting and storing username..."
#         flouser=$(echo ~ | awk -F/ '{print $NF}')
#         cd /home
#         for D in `find . -mindepth 1 -maxdepth 1 -type d`
#         do
#            cd ${D}
#            flouser=${D//./}
#done
         cat > /1/config/user.json << ENDOFFILE
       {"name":""}
ENDOFFILE
         contents="$(jq ".name = \"$flouser\"" /1/config/user.json)" && \
         echo "${contents}" > /1/config/user.json
#         sudo sed -i "s/user="blank"/user="${flouser}"/g" "$FLOPREFIX"usr/lib/floflis/config
         echo "Done!"
fi
fi
# <Core

# Install SSH:
if [ "$(df ~ | tail -1 | awk '{print $1;}')" != "/cow" ]; then
echo "DEBUG: Not a Live ISO"
if [ ! -e "$FLOPREFIX"usr/lib/floflis/layers/server ]
then
   echo "Don't install SSH if you think BIOS is a fossil fuel. And never use SSH to remotely access your devices in a public network, such as mobile. SSH can be useful for securer (than HTTP) downloads IF YOU ARE TECHY-SAVY AND UNDERSTAND ABOUT SSH. Estimated 1MB to download/6 MB installed."
   echo "Do you want to install SSH? [Y/n]"
   read instssh
   case $instssh in
      [nN])
         echo "${ok}"
         break ;;
      [yY])
         echo "Installing SSH..."
         sudo apt-get install ssh -y
         break ;;
      *)
         echo "${invalid}" ;;
esac
fi
fi

gnome-terminal --tab --title="Installer (root mode)" -- /bin/sh -c 'cd /home; sudo bash firstlogonroot.sh; exec bash'

until [ ! -e firstlogonroot.sh ]
do
   echo "Waiting to finish the 'Installer (root mode)'..."
   sleep 15s
done

if [ "$(df ~ | tail -1 | awk '{print $1;}')" != "/cow" ]; then
echo "DEBUG: Not a Live ISO"
cd "$FLOPREFIX"home/${flouser}/.config/autostart
sudo chmod +x IPFS.sh
sudo chown ${flouser}:${flouser} "$FLOPREFIX"home/${flouser}/.config/autostart/IPFS.sh
mv "$FLOPREFIX"home/${flouser}/.config/autostart/IPFS.sh "$FLOPREFIX"home/${flouser}/.config/autostart/IPFS.desktop
sudo chown ${flouser}:${flouser} "$FLOPREFIX"home/${flouser}/.config/autostart/IPFS.desktop

echo "- Initializing IPFS..."
ipfs init
echo "- To start IPFS service, open a new term window and type 'ipfs daemon', or restart your computer after Floflis is fully installed."
fi

# knows if upper layers are present, and install their firstlogon
          if [ -e "$FLOPREFIX"usr/lib/floflis/layers/soil ] || [ -e "$FLOPREFIX"usr/lib/floflis/layers/server ]
          then
             echo "- Upper layers are here. Detecting..."
# Server>
             if [ -f "$FLOPREFIX"usr/lib/floflis/layers/server/firstlogon.sh ];then
             echo "- Openning Floflis Server firstlogon installer..."
             sudo chmod +x "$FLOPREFIX"usr/lib/floflis/layers/server/firstlogon.sh && cd "$FLOPREFIX"usr/lib/floflis/layers/server && bash ./firstlogon.sh
fi
# <Server
# Soil>
             if [ -f "$FLOPREFIX"usr/lib/floflis/layers/soil/firstlogon.sh ];then
                echo "- Openning Floflis Soil firstlogon installer..."
                sudo chmod +x "$FLOPREFIX"usr/lib/floflis/layers/soil/firstlogon.sh && cd "$FLOPREFIX"usr/lib/floflis/layers/soil && bash ./firstlogon.sh
fi
# <Soil
# Grass>
             if [ -f "$FLOPREFIX"usr/lib/floflis/layers/grass/firstlogon.sh ];then
                echo "- Openning Floflis Grass firstlogon installer..."
                sudo chmod +x "$FLOPREFIX"usr/lib/floflis/layers/grass/firstlogon.sh && cd "$FLOPREFIX"usr/lib/floflis/layers/grass && bash ./firstlogon.sh
fi
# <Grass
# Base>
             if [ -f "$FLOPREFIX"usr/lib/floflis/layers/base/firstlogon.sh ];then
                echo "- Openning Floflis Base firstlogon installer..."
                sudo chmod +x "$FLOPREFIX"usr/lib/floflis/layers/base/firstlogon.sh && cd "$FLOPREFIX"usr/lib/floflis/layers/base && bash ./firstlogon.sh
fi
# <Base
# Home>
             if [ -f "$FLOPREFIX"usr/lib/floflis/layers"$FLOPREFIX"home/firstlogon.sh ];then
                echo "- Openning Floflis Home firstlogon installer..."
                sudo chmod +x "$FLOPREFIX"usr/lib/floflis/layers"$FLOPREFIX"home/firstlogon.sh && cd "$FLOPREFIX"usr/lib/floflis/layers/home && bash ./firstlogon.sh
fi
# <Home
# Ultimate>
             if [ -f "$FLOPREFIX"usr/lib/floflis/layers/ultimate/firstlogon.sh ];then
                echo "- Openning Floflis Ultimate firstlogon installer..."
                sudo chmod +x "$FLOPREFIX"usr/lib/floflis/layers/ultimate/firstlogon.sh && cd "$FLOPREFIX"usr/lib/floflis/layers/ultimate && bash ./firstlogon.sh
fi
# <Ultimate
# Planetary>
             if [ -f "$FLOPREFIX"usr/lib/floflis/layers/planetary/firstlogon.sh ];then
                echo "- Openning Floflis Planetary firstlogon installer..."
                sudo chmod +x "$FLOPREFIX"usr/lib/floflis/layers/planetary/firstlogon.sh && cd "$FLOPREFIX"usr/lib/floflis/layers/planetary && bash ./firstlogon.sh
fi
# <Planetary
fi          

echo "- Cleanning install..."
sudo rm -rf "$FLOPREFIX"home/firstlogon.sh
sudo rm -rf ${flouser}/.config/autostart/firstlogon.desktop
sudo chmod -R a+rwX "$FLOPREFIX"home/${flouser} && sudo chown ${flouser}:${flouser} "$FLOPREFIX"home/${flouser}

cd /home
for D in `find . -mindepth 1 -maxdepth 1 -type d`
do
   pure=$(echo "${D}" | tr -d "/" | tr -d ".")
   rm -f "$FLOPREFIX"home/$pure/.config/autostart/firstlogon.desktop
done

echo "(✓) Floflis has been successfully installed! You can now use it :)"

# run layers' finishing scripts here, so they do their needs
