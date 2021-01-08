#!/bin/bash

flouser=$(cat /1/config/dat.json | jq -r '.user')

sudo cat > /home/${flouser}/.config/autostart/IPFS.sh << ENDOFFILE
[Desktop Entry]
Type=Application
Exec=ipfsdaemon
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=IPFS
Name=IPFS
Comment[en_US]=
Comment=
Icon=utilities-terminal
StartupNotify=true
Terminal=false

ENDOFFILE
sudo chmod -R a+rwX /home/${flouser}/.config/autostart && sudo chown ${flouser}:${flouser} /home/${flouser}/.config/autostart
sudo chown ${flouser}:${flouser} /home/${flouser}/.local/share/gvfs-metadata/home*

echo "- Initializing IPFS..."
ipfs init
echo "- To start IPFS service, open a new term window and type 'ipfs daemon', or restart your computer after Floflis is fully installed."

echo "- Cleanning install..."
rm -rf firstlogonroot.sh
