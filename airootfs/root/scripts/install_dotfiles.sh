#!/bin/bash

echo "Cloning dotfiles..."
run_as_user git clone https://github.com/arch-anes/dotfiles.git

echo "Setting up dotfiles..."
run_as_user ~/dotfiles/setup.fish
