#!/bin/bash

### CONFIG ###
DISLOCKER=/media/bitlocker
MOUNTPOINT=/media/usb
##############

#error check
if [ $# -ne 1 ]; then
    echo "usage: $0 <disk> [-u]"
fi


if [ "$1" == "-u" ]; then
    #unmount
    umount -q $MOUNTPOINT
    umount -q $DISLOCKER
else
    #mount
    dislocker-fuse -V $1 -u $DISLOCKER
    if [ $? -eq 0 ]; then
        mount $DISLOCKER/dislocker-file $MOUNTPOINT -o loop
        if [ $? -eq 0 ]; then
            echo "mounted: $MOUNTPOINT"
        fi
    fi
fi
