#!/bin/bash

export FLOPREFIX
export flofmach && export flofdistro && export flofarch && export osfullname && export osname && export osversion && export osbuild && export osbuildcodename && export updatepatch && export year && export layer && export nxtlayer && export distrobase && export user && export specialbuildattempt

# update
if [ -f "$FLOPREFIX"usr/lib/floflis/layers/core/modules/update ]
then
    . "$FLOPREFIX"usr/lib/floflis/layers/core/modules/./update
fi
