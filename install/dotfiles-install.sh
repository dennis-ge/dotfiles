#!/bin/bash

echo_message "Create symlinks of dotfiles to home directory"
ln -sfv "$(pwd)/etc/bash/.bash_aliases" ~
ln -sfv "$(pwd)/etc/bash/.bashrc" ~
ln -sfv "$(pwd)/etc/readline/.inputrc" ~
ln -sfv "$(pwd)/etc/git/.gitconfig" ~
ln -sfv "$(pwd)/etc/git/.gitignore" ~
ln -sfv "$(pwd)/etc/git/.gitattributes" ~
ln -sfv "$(pwd)/etc/vim/.vimrc" ~

echo_message "Copy .vim folder to home directory"
cp -r "$(pwd)/etc/vim/.vim/" ~

source ~/.bashrc

echo_message "Don't forget to create your .gitconfig.local"
