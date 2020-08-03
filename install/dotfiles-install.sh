#!/bin/bash

echo_message "Create symlinks"
ln -sfv "$(pwd)/etc/bash/.bashrc" ~
ln -sfv "$(pwd)/etc/readline/.inputrc" ~
ln -sfv "$(pwd)/etc/git/.gitconfig" ~
ln -sfv "$(pwd)/etc/git/.gitattributes" ~
ln -sfv "$(pwd)/etc/vim/.vimrc" ~
