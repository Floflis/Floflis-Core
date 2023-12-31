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

#if [ $(jq -r '.patch_at' "$FLOPREFIX"usr/lib/web3updater/update.json) = "0" ]; then
#   echo "Installing update 1..."
   # place here the updates/commands of this first patch. always remember to increase numbers on new updates
#   contents="$(jq '.patch_at = "1"' "$FLOPREFIX"usr/lib/web3updater/update.json)" && \
#   echo "${contents}" > "$FLOPREFIX"usr/lib/web3updater/update.json
#fi

#if [ $(jq -r '.patch_at' "$FLOPREFIX"usr/lib/web3updater/update.json) = "1" ]; then
#   echo "Installing update 2..."
   # place here the updates/commands of this first patch. always remember to increase numbers on new updates
#   contents="$(jq '.patch_at = "2"' "$FLOPREFIX"usr/lib/web3updater/update.json)" && \
#   echo "${contents}" > "$FLOPREFIX"usr/lib/web3updater/update.json
#fi
