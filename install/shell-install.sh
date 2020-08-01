#!/bin/bash

tput setaf 2; echo "Create symlinks"; tput sgr0
ln -sfv "$(pwd)/etc/bash/.bashrc" ~
ln -sfv "$(pwd)/etc/readline/.inputrc" ~
ln -sfv "$(pwd)/etc/git/.gitconfig" ~
ln -sfv "$(pwd)/etc/git/.gitattributes" ~
