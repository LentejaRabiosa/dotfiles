#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Check if pkglist.txt exists
if [[ ! -f pkglist.txt ]]; then
    echo "Error: pkglist.txt not found in the current directory."
    exit 1
fi

# Sync package databases
echo "Updating package databases..."
pacman -Syu --noconfirm

# Install packages from pkglist.txt
echo "Installing packages..."
xargs -a pkglist.txt pacman -S --noconfirm --needed

echo "All packages installed successfully!"

