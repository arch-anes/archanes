#!/bin/bash

export ROOT_DIR="/mnt"
export BOOT_DIR="$ROOT_DIR/boot"
export CHROOT="arch-chroot $ROOT_DIR"

SCRIPTS_DIR="/root/scripts"

until ping archlinux.org -c 1; do
    echo "Unable to reach archlinux.org. Trying again soon."
    sleep 5
done

$SCRIPTS_DIR/partition_drive.sh

$SCRIPTS_DIR/rankmirrors.sh
$SCRIPTS_DIR/install_base.sh

$SCRIPTS_DIR/add_user.sh
$SCRIPTS_DIR/install_aur_helper.sh

export INSTALL_CMD="sudo -u $USERNAME yay -Syu --noconfirm --needed --noeditmenu"

$SCRIPTS_DIR/install_packages.sh
$SCRIPTS_DIR/install_boot.sh
$SCRIPTS_DIR/install_graphics_drivers.sh
$SCRIPTS_DIR/set_locale.sh
$SCRIPTS_DIR/set_hostname.sh
$SCRIPTS_DIR/set_root_pw.sh
