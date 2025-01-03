#!/usr/bin/env bash

# Directory where the dotfiles repository is located
DOTFILES_DIR=~/dotfiles

# Get the full path to the home directory
HOME_DIR=$(eval echo ~$USER)

# Create symlinks for directories
ln -sf "$DOTFILES_DIR/ghostty" "$HOME_DIR/.config/ghostty"
ln -sf "$DOTFILES_DIR/i3" "$HOME_DIR/.config/i3"
ln -sf "$DOTFILES_DIR/picom" "$HOME_DIR/.config/picom"
ln -sf "$DOTFILES_DIR/polybar" "$HOME_DIR/.config/polybar"
ln -sf "$DOTFILES_DIR/rofi" "$HOME_DIR/.config/rofi"

# Create symlinks for individual files
ln -sf "$DOTFILES_DIR/.gitignore" "$HOME_DIR/.config/.gitignore"
ln -sf "$DOTFILES_DIR/starship.toml" "$HOME_DIR/.config/starship.toml"

echo "Symlinks created successfully!"
