#!/bin/bash

source /root/helpers.sh

PKG_DIR=/root/packages

echo "Installaing explicit packages"
install_pkgs $(cat $PKG_DIR/*.explicit.pkg)

echo "Installaing dependency packages"
install_pkgs --asdep $(cat $PKG_DIR/*.dependency.pkg)
