#!/bin/zsh

function exit_error() {
  echo -e "\033[31m$1\033[00m" >&2
  exit 1
}

# Create configs directory
mkdir -p "$HOME/.zsh_profile.d/configs" ||
exit_error "Failed to setup config directory"

# Add link to init.sh in .zshrc file
echo -e "\n# Matt's ZSH Profile Improvements\nsource $HOME/.zsh_profile.d/init.sh\n" >> "$HOME/.zshrc" ||
exit_error "Failed to add initialisation line to $HOME/.zshrc"

echo -e "\033[32mInstallation Complete\033[00m"
