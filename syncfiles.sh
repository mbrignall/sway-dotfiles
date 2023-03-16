#!/bin/bash

# Define the list of folder names
folders=("fuzzel" "img" "mako" "sway" "swaylock" "waybar")

# Get the current directory and assign it to a variable
current_dir=$(pwd)

# Create directories if they don't exist
for folder in "${folders[@]}"
do
    if [ ! -d "$HOME/.config/$folder" ]; then
        mkdir -p "$HOME/.config/$folder"
    fi
done

# Symlink config files to the corresponding directories
ln -sf "$current_dir/config" "$HOME/.config/sway/config"
ln -sf "$current_dir/config" "$HOME/.config/swaylock/config"
ln -sf "$current_dir/config" "$HOME/.config/waybar/config"
ln -sf "$current_dir/config" "$HOME/.config/mako/config"

# Symlink fuzzel.ini to the fuzzel directory
ln -sf "$current_dir/fuzzel.ini" "$HOME/.config/fuzzel/fuzzel.ini"

# Symlink any images in $current_dir/img to the img directory
ln -sf "$current_dir/img/*" "$HOME/.config/img/"
