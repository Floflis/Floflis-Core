#!/bin/bash

flouser=$(jq -r '.name' /1/config/user.json)

cat > /home/${flouser}/.config/autostart/IPFS.sh << ENDOFFILE
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

# knows if upper layers are present, and install their firstlogonroot
          if [ -e /usr/lib/floflis/layers/soil ] || [ -e /usr/lib/floflis/layers/server ]
          then
             echo "- Upper layers are here. Detecting..."
# Server>
             if [ -f /usr/lib/floflis/layers/server/to-merge_firstlogonroot.sh ];then
             echo "- Openning Floflis Server firstlogon installer..."
             sudo chmod +x /usr/lib/floflis/layers/server/to-merge_firstlogonroot.sh && cd /usr/lib/floflis/layers/server && bash ./to-merge_firstlogonroot.sh
fi
# <Server
# Soil>
             if [ -f /usr/lib/floflis/layers/soil/to-merge_firstlogonroot.sh ];then
                echo "- Openning Floflis Soil firstlogon installer..."
                sudo chmod +x /usr/lib/floflis/layers/soil/to-merge_firstlogonroot.sh && cd /usr/lib/floflis/layers/soil && bash ./to-merge_firstlogonroot.sh
fi
# <Soil
# Grass>
             if [ -f /usr/lib/floflis/layers/grass/to-merge_firstlogonroot.sh ];then
                echo "- Openning Floflis Grass firstlogon installer..."
                sudo chmod +x /usr/lib/floflis/layers/grass/to-merge_firstlogonroot.sh && cd /usr/lib/floflis/layers/grass && bash ./to-merge_firstlogonroot.sh
fi
# <Grass
# Base>
             if [ -f /usr/lib/floflis/layers/base/to-merge_firstlogonroot.sh ];then
                echo "- Openning Floflis Base firstlogon installer..."
                sudo chmod +x /usr/lib/floflis/layers/base/to-merge_firstlogonroot.sh && cd /usr/lib/floflis/layers/base && bash ./to-merge_firstlogonroot.sh
fi
# <Base
# Home>
             if [ -f /usr/lib/floflis/layers/home/to-merge_firstlogonroot.sh ];then
                echo "- Openning Floflis Home firstlogon installer..."
                sudo chmod +x /usr/lib/floflis/layers/home/to-merge_firstlogonroot.sh && cd /usr/lib/floflis/layers/home && bash ./to-merge_firstlogonroot.sh
fi
# <Home
# Ultimate>
             if [ -f /usr/lib/floflis/layers/ultimate/to-merge_firstlogonroot.sh ];then
                echo "- Openning Floflis Ultimate firstlogon installer..."
                sudo chmod +x /usr/lib/floflis/layers/ultimate/to-merge_firstlogonroot.sh && cd /usr/lib/floflis/layers/ultimate && bash ./to-merge_firstlogonroot.sh
fi
# <Ultimate
# Planetary>
             if [ -f /usr/lib/floflis/layers/planetary/to-merge_firstlogonroot.sh ];then
                echo "- Openning Floflis Planetary firstlogon installer..."
                sudo chmod +x /usr/lib/floflis/layers/planetary/to-merge_firstlogonroot.sh && cd /usr/lib/floflis/layers/planetary && bash ./to-merge_firstlogonroot.sh
fi
# <Planetary
fi          

echo "- Cleanning install..."
rm -rf firstlogonroot.sh
