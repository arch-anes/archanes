#!/bin/bash

PKG_DIR=/root/packages

echo "Installaing explicit packages"
for file in $PKG_DIR/*.explicit.pkg; do install_pkgs $(cat $file); done

echo "Installaing dependency packages"
for file in $PKG_DIR/*.dependency.pkg; do install_pkgs --asdep $(cat $file); done
