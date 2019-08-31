#!/bin/bash

echo "Installing graphics drivers"

VGA=$(lspci | grep VGA)
case $VGA in
*AMD*)
  install_packages xf86-video-amdgpu amdgpu-fan radeon-profile-daemon-git
  enable_services amdgpu-fan.service radeon-profile-daemon.service
  ;;
*NVIDIA*)
  install_packages nvidia nvidia-utils lib32-nvidia-utils nvidia-settings
  ;;
*Intel*)
  install_packages xf86-video-intel
  ;;
*)
  echo -n "Unknown graphics card"
  ;;
esac
