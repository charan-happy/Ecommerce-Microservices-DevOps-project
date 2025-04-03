#!/bin/bash

set -e  # Exit the script immediately if a command fails
set -u  # Treat unset variables as an error

USER=$USER
PROJECT_DIR="/opt/ecomm"

echo "Updating System..."
sudo apt update && sudo apt upgrade -y || { echo "System update failed! Exiting..."; exit 1; }

echo "Installing Tools..."
packages=("git" "python3" "python3-pip" "nodejs" "npm" "openjdk-17-jdk" "golang-go" "docker.io")

for package in "${packages[@]}"; do
    if dpkg -l | grep -q "^ii  $package "; then
        installed_version=$(dpkg -l | grep "^ii  $package " | awk '{print $3}')
        echo "$package is already installed (version: $installed_version)."
        read -p "Do you want to upgrade $package to the latest version? (y/n): " choice
        if [[ "$choice" == "y" ]]; then
            sudo apt install --only-upgrade -y "$package" || { echo "Failed to upgrade $package! Exiting..."; exit 1; }
            echo "$package upgraded successfully."
        else
            echo "$package upgrade skipped."
        fi
    else
        sudo apt install -y "$package" || { echo "Failed to install $package! Exiting..."; exit 1; }
        echo "$package installed successfully."
    fi
done

echo "Configuring Docker..."
sudo systemctl enable docker || { echo "Failed to enable Docker! Exiting..."; exit 1; }
sudo systemctl start docker || { echo "Failed to start Docker! Exiting..."; exit 1; }
sudo usermod -aG docker "$USER" || { echo "Failed to add user to Docker group! Exiting..."; exit 1; }

echo "Creating Project directories..."
if ! sudo mkdir -p "$PROJECT_DIR"; then
    echo "Failed to create project directory! Exiting..."
    exit 1
fi

sudo chown "$USER:$USER" "$PROJECT_DIR" || { echo "Failed to set ownership for project directory! Exiting..."; exit 1; }
cd "$PROJECT_DIR" || { echo "Failed to navigate to project directory! Exiting..."; exit 1; }
mkdir -p user-service product-service order-service recommend-service || { echo "Failed to create subdirectories! Exiting..."; exit 1; }

echo "Verifying Installations..."
commands=("git --version" "python3 --version" "node -v" "java --version" "go version" "docker --version")

for cmd in "${commands[@]}"; do
    if ! eval "$cmd"; then
        echo "Verification failed for command: $cmd. Exiting..."
        exit 1
    fi
done

echo "Setup complete! Log out and back in for Docker group changes."

