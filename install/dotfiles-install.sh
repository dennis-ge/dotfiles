#!/bin/bash

echo_message "Create symlinks to home directory"
ln -sfv "$(pwd)/etc/bash/.bashrc" ~
ln -sfv "$(pwd)/etc/readline/.inputrc" ~
cp -r "$(pwd)/etc/git/.gitconfig" ~ # Can't link since the it is possible that the credential manager is added
if [[ is_ubuntu_wsl ]]; 
then
    git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager.exe"
fi
ln -sfv "$(pwd)/etc/git/.gitattributes" ~
ln -sfv "$(pwd)/etc/vim/.vimrc" ~

echo_message "Copy .vim folder to home directory"
cp -r "$(pwd)/etc/vim/.vim/" ~
