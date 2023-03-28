#!/bin/bash

# Check if running on a supported OS (Linux or macOS)
if [[ "$(uname)" == "Linux" ]]; then
  # Check if sudo is available
  if ! command -v sudo &> /dev/null; then
    echo "Error: sudo is required but not found. Aborting."
    exit 1
  fi

  # Install Nix on Linux with sudo
  sudo sh <(curl -L https://nixos.org/nix/install) --daemon
elif [[ "$(uname)" == "Darwin" ]]; then
  # Check if Homebrew is available
  if ! command -v brew &> /dev/null; then
    echo "Error: Homebrew is required but not found. Aborting."
    exit 1
  fi

  # Install Nix on macOS with Homebrew
  brew install nix
else
  echo "Error: unsupported OS. Aborting."
  exit 1
fi

# List of programs to install
programs=("nodejs" "tealdeer" "bat" "fd" "fzf" "starship" "tealdeer" "tokei" "zip" "zoxide")

# Install each program in the list
for program in "${programs[@]}"; do
  echo "Installing $program..."
  nixi "$program"
done

