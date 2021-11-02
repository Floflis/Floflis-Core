#!/bin/bash
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

flouser=$(logname) # considers as main user, the first logged user after first boot 💃

# Core>
   if [ -e /usr/lib/floflis/layers/dna/floflis ]
   then
      if [ -e /usr/lib/floflis/layers/core ]
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
#         sudo sed -i "s/user="blank"/user="${flouser}"/g" /usr/lib/floflis/config
fi
fi
# <Core

# Install SSH:

if [ ! -e /usr/lib/floflis/layers/server ]
then
   echo "Don't install SSH if you think BIOS is a fossil fuel. And never use SSH to remotely access your devices in a public network, such as mobile. SSH can be useful for securer (than HTTP) downloads. Estimated 1MB to download/6 MB installed."
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

gnome-terminal --tab --title="Installer (root mode)" -- /bin/sh -c 'cd /home; sudo sh ./firstlogonroot.sh; exec bash'

until [ ! -e firstlogonroot.sh ]
do
   echo "Waiting to finish the 'Installer (root mode)'..."
   sleep 15s
done

cd /home/${flouser}/.config/autostart
sudo chmod +x IPFS.sh
sudo chown ${flouser}:${flouser} /home/${flouser}/.config/autostart/IPFS.sh
mv /home/${flouser}/.config/autostart/IPFS.sh /home/${flouser}/.config/autostart/IPFS.desktop
sudo chown ${flouser}:${flouser} /home/${flouser}/.config/autostart/IPFS.desktop

echo "- Initializing IPFS..."
ipfs init
echo "- To start IPFS service, open a new term window and type 'ipfs daemon', or restart your computer after Floflis is fully installed."

echo "- Cleanning install..."
sudo rm -rf /home/firstlogon.sh
sudo rm -rf ${flouser}/.config/autostart/firstlogon.desktop
sudo chmod -R a+rwX /home/${flouser} && sudo chown ${flouser}:${flouser} /home/${flouser}

cd /home
for D in `find . -mindepth 1 -maxdepth 1 -type d`
do
   pure=$(echo "${D}" | tr -d "/" | tr -d ".")
   rm -f /home/$pure/.config/autostart/firstlogon.desktop
done

echo "(✓) Floflis has been successfully installed! You can now use it :)"
