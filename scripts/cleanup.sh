#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -u  # Treat unset variables as an error

# List of packages to remove
packages=("git" "nodejs" "npm" "openjdk-17-jdk" "golang-go" "docker.io")

# Project directory to delete
PROJECT_DIR="/opt/ecomm"

echo "Removing installed packages..."
for package in "${packages[@]}"; do
    if dpkg -l | grep -q "^ii  $package "; then
        echo "Removing $package..."
        sudo apt purge --auto-remove -y "$package" || { echo "Failed to remove $package! Exiting..."; exit 1; }
        echo "$package removed successfully."
    else
        echo "$package is not installed. Skipping..."
    fi
done

echo "Cleaning up package cache..."
sudo apt autoremove -y || { echo "Failed to autoremove unused packages! Exiting..."; exit 1; }
sudo apt clean || { echo "Failed to clean package cache! Exiting..."; exit 1; }

echo "Stopping and disabling Docker service..."
if systemctl is-active --quiet docker; then
    sudo systemctl stop docker || { echo "Failed to stop Docker! Exiting..."; exit 1; }
fi

if systemctl is-enabled --quiet docker; then
    sudo systemctl disable docker || { echo "Failed to disable Docker! Exiting..."; exit 1; }
fi

echo "Deleting project directories..."
if [ -d "$PROJECT_DIR" ]; then
    sudo rm -rf "$PROJECT_DIR" || { echo "Failed to delete project directory! Exiting..."; exit 1; }
    echo "$PROJECT_DIR deleted successfully."
else
    echo "$PROJECT_DIR does not exist. Skipping..."
fi

echo "System cleanup complete!"

