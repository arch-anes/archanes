#!/bin/bash

PKG_DIR=/root/packages

echo "Installaing explicit packages"
install_packages $(cat $PKG_DIR/*.explicit.pkg)

echo "Installaing dependency packages"
install_packages_dependencies $(cat $PKG_DIR/*.dependency.pkg)
