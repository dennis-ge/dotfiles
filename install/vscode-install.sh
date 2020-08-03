#!/bin/bash

# Abort if the System is not Ubuntu Desktop
is_ubuntu_desktop || return 1

extensions=(
	"hookyqr.beautify"
	"equinusocio.vsc-community-material-theme"
	"eamodio.gitlens"
	"ms-azuretools.vscode-docker"
	"ms-vscode.vscode-typescript-tslint-plugin"
	"ms-vscode.notepadplusplus-keybindings"
	"ms-python.python"
	"christian-kohler.path-intellisense"
	"visualstudioexptteam.vscodeintellicode"
	"pkief.material-icon-theme"
	"equinusocio.vsc-material-theme"
)

# Install VS Code
sudo snap install --classic code

if [ $? = 0 ];
then
	echo_message "vscode successfully installed"
    new_small_separator

	for extension in "${extensions[@]}"
	do
		code --install-extension $extension
	done

	# Copy settings.json
	new_small_separator
	rm ~/.config/Code/User/settings.json
	ln -sfv /../vscode/settings.json ~/.config/Code/User/
    echo_message "global settings.json file linked to local one"
else
    echo_error "vscode  installation failed"
fi
