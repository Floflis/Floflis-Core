#!/bin/bash

# update
if [ -f "$FLOPREFIX"usr/lib/floflis/layers/core/modules/update ]
then
    . "$FLOPREFIX"usr/lib/floflis/layers/core/modules/./update
fi
