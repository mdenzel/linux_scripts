#!/bin/bash

### CONFIG ###
SHARE=
HD=./machine.qcow2
CPUS=2
RAM=4096
##############

if [ "$SHARE" == "" ]; then
    qemu-system-x86_64 -net nic -net user -smp $CPUS -cpu host -enable-kvm -m $RAM -drive format=qcow2,file=$HD
else
    qemu-system-x86_64 -net nic -net user,smb=$SHARE -smp $CPUS -cpu host -enable-kvm -m $RAM -drive format=qcow2,file=$HD
fi

