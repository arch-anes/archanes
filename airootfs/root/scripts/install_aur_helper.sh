#!/bin/bash

echo "Installaing AUR helper"

BUILD_DIR="/home/$USERNAME"
CLONE_DIR="$BUILD_DIR/yay"

git clone https://aur.archlinux.org/yay.git $ROOT_DIR$CLONE_DIR
$CHROOT chown $USERNAME:users -R $CLONE_DIR
until $CHROOT bash -c "pushd $CLONE_DIR && sudo -u $USERNAME makepkg --noconfirm --syncdeps --install"; do
    :
done

rm -rf $CLONE_DIR
