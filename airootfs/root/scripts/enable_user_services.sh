#!/bin/bash

echo "Enabling networking services"
enable_services NetworkManager.service bluetooth.service

echo "Enabling Syncthing"
enable_services syncthing@$USERNAME.service

echo "Enabling Docker"
$CHROOT gpasswd -a $USERNAME docker
enable_services docker.service

echo "Enabling MPD"
enable_services --user mpd.service

echo "Enabling firewall"
$CHROOT ufw enable
