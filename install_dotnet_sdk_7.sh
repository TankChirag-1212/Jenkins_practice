#!/bin/bash

# Check if running as root
if [ "$EUID" -eq 0 ]; then
  echo "Please do not run as root, this script installs .NET SDK in the user's home directory."
  exit 1
fi

# Download .NET SDK 7
echo "Downloading .NET SDK 7..."
curl -O https://download.visualstudio.microsoft.com/download/pr/dbfe6cc7-dd82-4cec-b267-31ed988b1652/c60ab4793c3714be878abcb9aa834b63/dotnet-sdk-7.0.400-linux-x64.tar.gz

# Create directory for .NET SDK
echo "Creating directory for .NET SDK..."
mkdir -p $HOME/dotnet

# Extract .NET SDK
echo "Extracting .NET SDK..."
tar zxf dotnet-sdk-7.0.400-linux-x64.tar.gz -C $HOME/dotnet

# Set up environment variables
echo "Setting up environment variables..."
export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet

# Make environment variables persistent
read -p "Do you want to make these environment variables persistent? (y/n): " choice
if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
  echo "export DOTNET_ROOT=$HOME/dotnet" >> $HOME/.bashrc
  echo "export PATH=\$PATH:\$HOME/dotnet" >> $HOME/.bashrc
  echo "Environment variables have been added to $HOME/.bashrc"
fi

# Cleanup
echo "Cleaning up downloaded files..."
rm dotnet-sdk-7.0.400-linux-x64.tar.gz

# Installation complete
echo ".NET SDK 7 installation is complete!"

# Verify the installation
dotnet --version
