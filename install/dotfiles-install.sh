#!/usr/bin/env bash
echo_message "Create symlinks of dotfiles to home directory";

# Get all dotfiles except the 'dot' and 'dot dot' dir 
DOTFILES=$(pwd)/etc/dotfiles/.[^.]*   

for file in $DOTFILES; do
    ln -sfv $file ~/
done

echo_message "Copy .vim folder to home directory";
cp -r "$(pwd)/etc/.vim/" ~;

echo_message "Don't forget to create your .gitconfig.local";
