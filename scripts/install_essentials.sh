#!/bin/bash

# Create and change to the 'install' directory
mkdir install
cd install

# Install LSD
curl -L -o lsd_0.23.1_amd64.deb "https://github.com/lsd-rs/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb"
sudo dpkg -i lsd_0.23.1_amd64.deb
rm lsd_0.23.1_amd64.deb

# Install Zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
export PATH=$PATH:$HOME/.local/bin

# Install ble.sh
curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf -
mkdir -p ~/.local/share/blesh
cp -Rf ble-nightly/* ~/.local/share/blesh/
rm -rf ble-nightly

# Install Nerd Font
# Use fc-list to check installed fonts, -i for case-insensitive, -q for quiet (no output)
if fc-list | grep -iq "JetBrains.*Nerd Font"; then
    echo "JetBrainsMono Nerd Font is already installed. Skipping."
else
    echo "JetBrainsMono Nerd Font not found. Installing..."
    
    # Create a local fonts directory if it doesn't exist
    mkdir -p ~/.local/share/fonts
    
    # Download the latest JetBrainsMono Nerd Font
    wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip -O /tmp/JetBrainsMono.zip
    
    # Unzip it into your fonts folder
    unzip -o /tmp/JetBrainsMono.zip -d ~/.local/share/fonts/
    
    # Refresh your system's font cache
    fc-cache -fv
    
    # Clean up the downloaded zip file so it doesn't linger
    rm /tmp/JetBrainsMono.zip
    
    echo "JetBrainsMono Nerd Font installed successfully!"
fi
 
# Change back to the previous directory & delete install
cd .. && rm -rf install

# Source bashrc
source ~/.bashrc
