#!/bin/bash

echo "Installing graphics drivers"

VGA=$(lspci | grep VGA)
case $VGA in
*AMD*)
  $CHROOT $INSTALL_CMD xf86-video-amdgpu mesa lib32-mesa amdgpu-fan
  $CHROOT systemctl enable amdgpu-fan.service
  ;;
*NVIDIA*)
  $CHROOT $INSTALL_CMD nvidia nvidia-utils lib32-nvidia-utils nvidia-settings
  ;;
*Intel*)
  $CHROOT $INSTALL_CMD xf86-video-intel mesa lib32-mesa
  ;;
*)
  echo -n "Unknown graphics card"
  ;;
esac
