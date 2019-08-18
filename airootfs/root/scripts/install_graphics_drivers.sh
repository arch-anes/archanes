#!/bin/bash

source /root/helpers.sh

echo "Installing graphics drivers"

VGA=$(lspci | grep VGA)
case $VGA in
*AMD*)
  install_pkgs xf86-video-amdgpu mesa lib32-mesa amdgpu-fan
  $CHROOT systemctl enable amdgpu-fan.service
  ;;
*NVIDIA*)
  install_pkgs nvidia nvidia-utils lib32-nvidia-utils nvidia-settings
  ;;
*Intel*)
  install_pkgs xf86-video-intel mesa lib32-mesa
  ;;
*)
  echo -n "Unknown graphics card"
  ;;
esac
