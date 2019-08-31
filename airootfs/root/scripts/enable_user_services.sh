#!/bin/bash

echo "Enabling networking services"
enable_services NetworkManager.service bluetooth.service

echo "Enabling Syncthing"
enable_services syncthing@$USERNAME.service
