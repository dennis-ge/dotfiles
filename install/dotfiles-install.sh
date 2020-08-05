#!/bin/bash

echo_message "Create symlinks to home directory"
ln -sfv "$(pwd)/etc/bash/.bashrc" ~
ln -sfv "$(pwd)/etc/readline/.inputrc" ~
ln -sfv "$(pwd)/etc/git/.gitconfig" ~
ln -sfv "$(pwd)/etc/git/.gitattributes" ~
ln -sfv "$(pwd)/etc/vim/.vimrc" ~

echo_message "Copy .vim folder to home directory"
cp -r "$(pwd)/etc/vim/.vim/" ~
