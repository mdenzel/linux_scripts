#!/bin/bash

VERSION=$(( `cat /etc/os-release | grep VERSION_ID | cut -d '=' -f2` + 1 ))
echo "Getting Fedora $VERSION"

sudo dnf --refresh upgrade || exit 13
sudo dnf install dnf-plugin-system-upgrade || exit 13
sudo dnf system-upgrade download --refresh --releasever=$VERSION || exit 13
sudo dnf system-upgrade reboot || exit 13
