#!/bin/bash

# Create and change to the 'install' directory
mkdir install
cd install

# Install LSD
curl -L -o lsd_0.23.1_amd64.deb "https://github.com/lsd-rs/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb"
sudo dpkg -i lsd_0.23.1_amd64.deb
rm lsd_0.23.1_amd64.deb

# Install Starship
curl -sS https://starship.rs/install.sh | sh

# Install Zoxide
# curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/ajeetdsouza/zoxide/master/install.sh | sh

# Change back to the previous directory
cd ..

# Source bashrc
source ~/.bashrc