#!/bin/bash

# Define the list of folder names
folders=("fuzzel" "mako" "sway" "swaylock" "waybar")

# Get the current directory and assign it to a variable
current_dir=$(pwd)

# Print a summary of the changes that will be made
echo "This script will create the following directories in ~/.config and symlink the files within back to the $current_dir directory:"
echo "- alacritty"
echo "- fuzzel"
echo "- mako"
echo "- sway"
echo "- swaylock"
echo "- waybar"
echo ""
echo "The following files will be symlinked:"
echo "- config to ~/.config/sway/config, ~/.config/swaylock/config, ~/.config/waybar/config, and ~/.config/mako/config"
echo "- fuzzel.ini to ~/.config/fuzzel/fuzzel.ini"
echo ""

# Prompt for confirmation
read -p "Do you want to continue? (y/n) " answer

if [ "$answer" != "${answer#[Yy]}" ]; then
  # Remove directories if they exist and create new ones
  for folder in "${folders[@]}"; do
    if [ -d "$HOME/.config/$folder" ]; then
      rm -rf "$HOME/.config/$folder"
      echo "Removed directory $HOME/.config/$folder"
    fi
    mkdir -p "$HOME/.config/$folder"
    echo "Created directory $HOME/.config/$folder"
  done

  # Symlink config files to the corresponding directories
  for folder in "sway" "swaylock" "waybar" "mako"; do
    target_dir="$HOME/.config/$folder"
    target_file="$target_dir/config"
    if [ ! -e "$target_file" ]; then
      ln -s "$current_dir/$folder/config" "$target_file"
      echo "Symlinked config to $target_dir"
    fi
  done
  target_dir="$HOME/.config/fuzzel"
  target_file="$target_dir/fuzzel.ini"
  if [ ! -e "$target_file" ]; then
    ln -s "$current_dir/fuzzel/fuzzel.ini" "$target_file"
    echo "Symlinked fuzzel.ini to $target_dir"
  fi
  target_dir="$HOME/.config/waybar"
  target_file="$target_dir/style.css"
  if [ ! -e "$target_file" ]; then
    ln -s "$current_dir/waybar/style.css" "$target_file"
    echo "Symlinked style.css to $target_dir"
  fi
  target_dir="$HOME/.config/alacritty"
  target_file="$target_dir/alacritty.ini"
  if [ ! -e "$target_file" ]; then
    ln -s "$current_dir/alacritty/alacritty.ini" "$target_file"
    echo "Symlinked alacritty.ini to $target_dir"
  fi

  sudo cp "$current_dir/img/wallpaper.jpg" /usr/share/backgrounds/

  echo "Done!"
else
  echo "Aborted."
fi
