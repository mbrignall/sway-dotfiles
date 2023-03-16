#!/bin/bash

# Define the list of folder names
folders=("fuzzel" "mako" "sway" "swaylock" "waybar")

# Get the current directory and assign it to a variable
current_dir=$(pwd)

# Print a summary of the changes that will be made
echo "This script will create the following directories in ~/.config and symlink the files within back to the $current_dir directory:"
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
    # Create directories if they don't exist
    for folder in "${folders[@]}"
    do
        if [ ! -d "$HOME/.config/$folder" ]; then
            mkdir -p "$HOME/.config/$folder"
            echo "Created directory $HOME/.config/$folder"
        fi
    done

    # Symlink config files to the corresponding directories
    for file in "$current_dir/config" "$current_dir/fuzzel.ini"
    do
        filename=$(basename "$file")
        for folder in "sway" "swaylock" "waybar" "mako" "fuzzel"
        do
            target_dir="$HOME/.config/$folder"
            target_file="$target_dir/$filename"
            if [ ! -e "$target_file" ]; then
                ln -s "$file" "$target_file"
                echo "Symlinked $filename to $target_dir"
            fi
        done
    done

    echo "Done!"
else
    echo "Aborted."
fi
