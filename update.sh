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

dna_ascii=""" 
-. .-.   .-. .-.   .-. .-.   .
  \   \ /   \   \ /   \   \ /
 / \   \   / \   \   / \   \
~   `-~ `-`   `-~ `-`   `-~ `-
"""
#
echo "${dna_ascii}"
#
cat << "EOF"

  _            _           
 |_  |   _   _|_  |  o   _ 
 |   |  (_)   |   |  |  _>  
           
           Update

EOF

if [ "$updatepatch" = "0" ]; then
   echo "Updating Floflis to FU1..." && echo "${dna_ascii}"
   # here are the actions performed by this update patch
   # update status an progress is stored on texty file, so Floflis Update UI can use it
   
   # Update makes use of an API, where Floflis Update binary decides what to execute
   # API also supports to store when an update requires restart
   # API also supports kernel updates, if user chooses rolling release
   # "flo update" cmd runs floupdate bin
   
   # the user or custom-distro decides what to approve (user's pending updates are stored on backstage for review, until they are approved as safe)
   # updates on backstage could have peer-review
   # in an upcoming update, Floflis Update and UniStore will use Web3 Updater lib instead of their own. also, Floflis' binaries will be from UniStore, and .sh scripts will have their own ASCII icons.
   echo "Ok, updates have been applied."
   echo "Updating config file to register FU$updatepatch+1 update..." && echo "${dna_ascii}" #need to work/experimental
   $maysudo sed -i 's/updatepatch="0"/updatepatch="1"/g' "$FLOPREFIX"usr/lib/floflis/config
   echo "(✓) Success! Your Floflis has been updated."
fi
