#!/bin/bash

flouser=$(jq -r '.name' /1/config/user.json)

if [ "$(df ~ | tail -1 | awk '{print $1;}')" != "/cow" ]; then
echo "DEBUG: Not a Live ISO"
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
fi

echo "- Cleanning install..."
rm -rf firstlogonroot.sh
