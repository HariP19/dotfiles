#!/bin/bash
set -e

# Setup commands to run inside the container to make it ready for dotfiles
PREPARE_CONTAINER="
echo '---------------------------------------------------'
echo 'Step 1: Installing prerequisites (sudo, git, curl, xz-utils)...'
apt-get update >/dev/null
apt-get install -y sudo git curl xz-utils nano file locales >/dev/null

# Determine locale to avoid perl warnings
locale-gen en_US.UTF-8
export LANG=en_US.UTF-8
export USER=\$(whoami)
"

# The robust dotfiles setup snippet you requested
SETUP_DOTFILES="
echo '---------------------------------------------------'
echo 'Configuring Dotfiles...'

# Check for required commands (sudo, git, curl, xz)
if ! command -v sudo >/dev/null || ! command -v git >/dev/null || ! command -v curl >/dev/null || ! command -v xz >/dev/null; then
    echo "Skipping dotfiles setup: Missing required dependencies (sudo, git, curl, xz)."
else
    # Check for dotfiles directory
    if [ -d "$HOME/dotfiles" ]; then
        echo "Found dotfiles at $HOME/dotfiles"
        cd "$HOME/dotfiles/scripts"
        
        echo 'Running install_essentials.sh...'
        chmod +x install_essentials.sh
        ./install_essentials.sh

        echo 'Running setup.sh...'
        chmod +x setup.sh
        ./setup.sh
        
        echo 'Setup Complete.'
    else
        echo "Skipping dotfiles setup: Directory $HOME/dotfiles not found."
    fi
fi

echo '---------------------------------------------------'
exec bash
"

echo "Starting Docker container to test dotfiles..."
echo "Mounting $(pwd) to /root/dotfiles"

# Run Ubuntu 24.04 container with the prepared environment + robust setup script
docker run --rm -it \
    -v "$(pwd):/root/dotfiles" \
    -w /root/dotfiles \
    ubuntu:24.04 \
    bash -c "${PREPARE_CONTAINER}${SETUP_DOTFILES}"
