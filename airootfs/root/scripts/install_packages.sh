#!/bin/bash

PKG_DIR=/root/packages

echo "Installaing explicit packages"
for file in $PKG_DIR/*.explicit.pkg; do $INSTALL_CMD $(cat $file); done

echo "Installaing dependency packages"
for file in $PKG_DIR/*.dependency.pkg; do $INSTALL_CMD --asdep $(cat $file); done
