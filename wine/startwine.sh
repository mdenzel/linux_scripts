#!/bin/bash

#get current directory
DIR=`pwd`

#execute wine here
if [ $# -eq 0 ]; then
    WINEPREFIX=$DIR WINEARCH=win32 winecfg
else
    WINEPREFIX=$DIR WINEARCH=win32 wine $1
fi
