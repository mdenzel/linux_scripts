#!/bin/bash

### CONFIG ###
MOUNT=/media/tmp
VERA=${VERA:-/dev/sdb1} #default value /dev/sdb1
##############

if [ "$1" == "-u" ]; then
    sudo veracrypt -t -d $VERA
else
    sudo veracrypt -t -k "" --pim=0 --protect-hidden=no $VERA $MOUNT
fi

