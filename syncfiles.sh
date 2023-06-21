#!/bin/bash

# Define the list of folder names
folders=("fuzzel" "mako" "sway" "swaylock" "waybar" "alacritty")

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
echo "- config to ~/.config/alacritty/alacritty.ini, /.config/sway/config, ~/.config/swaylock/config, ~/.config/waybar/config, and ~/.config/mako/config"
echo "- fuzzel.ini to ~/.config/fuzzel/fuzzel.ini"
echo ""

# Prompt for confirmation
read -rp "Do you want to continue? (y/n) " answer

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
        ln -s "$current_dir/alacritty.ini" "$target_file"
        echo "Symlinked alacritty.ini to $target_dir"
    fi

    # Prompt for wallpaper choice
    echo ""
    echo "Choose a wallpaper:"
    echo "1. wallpaper1.jpg"
    echo "2. wallpaper2.jpg"
    read -rp "Enter the number of the wallpaper: " wallpaper_choice

    case $wallpaper_choice in
        1)
            wallpaper_file="$current_dir/img/wallpaper1.jpg"
            ;;
        2)
            wallpaper_file="$current_dir/img/wallpaper2.jpg"
            ;;
        *)
            echo "Aborted."
            exit 1
            ;;
    esac

    sudo mkdir -p "$HOME/.local/share/wallpapers/"
    sudo cp "$wallpaper_file" "$HOME/.local/share/wallpapers/wallpaper.jpg"

    echo "Done!"
else
    echo "Aborted."
fi
