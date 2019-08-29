#!/bin/bash

echo "Enter hostname:"
while [ -z "$NEW_HOSTNAME" ]; do
    read -a NEW_HOSTNAME
done

echo "Setting hostname to '$NEW_HOSTNAME'"
echo $NEW_HOSTNAME >$ROOT_DIR/etc/hostname

echo "Enabling NetworkManager"
$CHROOT systemctl enable NetworkManager
