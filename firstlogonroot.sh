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

flouser=$(jq -r '.name' "$FLOPREFIX"1/config/user.json)

cat > "$FLOPREFIX"home/${flouser}/.config/autostart/IPFS.sh << ENDOFFILE
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
sudo chmod -R a+rwX "$FLOPREFIX"home/${flouser}/.config/autostart && sudo chown ${flouser}:${flouser} "$FLOPREFIX"home/${flouser}/.config/autostart
sudo chown ${flouser}:${flouser} "$FLOPREFIX"home/${flouser}/.local/share/gvfs-metadata/home*
sudo chown ${flouser}:${flouser} "$FLOPREFIX"home/${flouser}/.local/share/gvfs-metadata/home

# knows if upper layers are present, and install their firstlogonroot
          if [ -e "$FLOPREFIX"usr/lib/floflis/layers/soil ] || [ -e "$FLOPREFIX"usr/lib/floflis/layers/server ]
          then
             echo "- Upper layers are here. Detecting..."
# Server>
             if [ -f "$FLOPREFIX"usr/lib/floflis/layers/server/firstlogonroot.sh ];then
             echo "- Openning Floflis Server firstlogon installer..."
             sudo chmod +x "$FLOPREFIX"usr/lib/floflis/layers/server/firstlogonroot.sh && cd "$FLOPREFIX"usr/lib/floflis/layers/server && bash ./firstlogonroot.sh
fi
# <Server
# Soil>
             if [ -f "$FLOPREFIX"usr/lib/floflis/layers/soil/firstlogonroot.sh ];then
                echo "- Openning Floflis Soil firstlogon installer..."
                sudo chmod +x "$FLOPREFIX"usr/lib/floflis/layers/soil/firstlogonroot.sh && cd "$FLOPREFIX"usr/lib/floflis/layers/soil && bash ./firstlogonroot.sh
fi
# <Soil
# Grass>
             if [ -f "$FLOPREFIX"usr/lib/floflis/layers/grass/firstlogonroot.sh ];then
                echo "- Openning Floflis Grass firstlogon installer..."
                sudo chmod +x "$FLOPREFIX"usr/lib/floflis/layers/grass/firstlogonroot.sh && cd "$FLOPREFIX"usr/lib/floflis/layers/grass && bash ./firstlogonroot.sh
fi
# <Grass
# Base>
             if [ -f "$FLOPREFIX"usr/lib/floflis/layers/base/firstlogonroot.sh ];then
                echo "- Openning Floflis Base firstlogon installer..."
                sudo chmod +x "$FLOPREFIX"usr/lib/floflis/layers/base/firstlogonroot.sh && cd "$FLOPREFIX"usr/lib/floflis/layers/base && bash ./firstlogonroot.sh
fi
# <Base
# Home>
             if [ -f "$FLOPREFIX"usr/lib/floflis/layers/home/firstlogonroot.sh ];then
                echo "- Openning Floflis Home firstlogon installer..."
                sudo chmod +x "$FLOPREFIX"usr/lib/floflis/layers/home/firstlogonroot.sh && cd "$FLOPREFIX"usr/lib/floflis/layers/home && bash ./firstlogonroot.sh
fi
# <Home
# Ultimate>
             if [ -f "$FLOPREFIX"usr/lib/floflis/layers/ultimate/firstlogonroot.sh ];then
                echo "- Openning Floflis Ultimate firstlogon installer..."
                sudo chmod +x "$FLOPREFIX"usr/lib/floflis/layers/ultimate/firstlogonroot.sh && cd "$FLOPREFIX"usr/lib/floflis/layers/ultimate && bash ./firstlogonroot.sh
fi
# <Ultimate
# Planetary>
             if [ -f "$FLOPREFIX"usr/lib/floflis/layers/planetary/firstlogonroot.sh ];then
                echo "- Openning Floflis Planetary firstlogon installer..."
                sudo chmod +x "$FLOPREFIX"usr/lib/floflis/layers/planetary/firstlogonroot.sh && cd "$FLOPREFIX"usr/lib/floflis/layers/planetary && bash ./firstlogonroot.sh
fi
# <Planetary
# Quantum>
             if [ -f "$FLOPREFIX"usr/lib/floflis/layers/quantum/firstlogonroot.sh ];then
                echo "- Openning Floflis Quantum firstlogon installer..."
                sudo chmod +x "$FLOPREFIX"usr/lib/floflis/layers/quantum/firstlogonroot.sh && cd "$FLOPREFIX"usr/lib/floflis/layers/quantum && bash ./firstlogonroot.sh
fi
# <Quantum
fi          

echo "- Cleanning install..."
rm "$FLOPREFIX"home/firstlogonroot.sh
