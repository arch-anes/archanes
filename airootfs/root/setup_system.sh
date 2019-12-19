#!/bin/bash

source /root/helpers.sh

export ROOT_DIR="/mnt"
export BOOT_DIR="$ROOT_DIR/boot"
export CHROOT="arch-chroot $ROOT_DIR"

SCRIPTS_DIR="/root/scripts"
CONFIGS_DIR="/root/configs"

wait_for_internet

execute_script "$SCRIPTS_DIR/partition_drive.sh"

execute_script "$SCRIPTS_DIR/rankmirrors.sh"
execute_script "$SCRIPTS_DIR/install_base.sh"
execute_script "$SCRIPTS_DIR/set_locale.sh"

execute_script "$SCRIPTS_DIR/add_user.sh"
execute_script "$SCRIPTS_DIR/install_aur_helper.sh"

execute_script "$SCRIPTS_DIR/install_user_packages.sh"
execute_script "$SCRIPTS_DIR/install_graphics_drivers.sh"
execute_script "$SCRIPTS_DIR/install_boot.sh"

execute_script "$SCRIPTS_DIR/set_hostname.sh"
execute_script "$SCRIPTS_DIR/enable_user_services.sh"
execute_script "$SCRIPTS_DIR/set_root_pw.sh"

execute_script "$SCRIPTS_DIR/install_dotfiles.sh"
