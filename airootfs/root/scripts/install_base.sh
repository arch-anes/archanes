#!/bin/bash

echo "Installing base system"
pacstrap $ROOT_DIR base base-devel

echo "Generating fstab"
genfstab -U $ROOT_DIR >$ROOT_DIR/etc/fstab

echo "Copying ranked mirrors"
MIRRORLIST=etc/pacman.d/mirrorlist
cp -f "/$MIRRORLIST" "$ROOT_DIR/$MIRRORLIST"
