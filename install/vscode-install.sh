#!/bin/bash

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

if [[ is_ubuntu_wsl -eq 1 ]] ; 
then
	# Install VS Code
	sudo snap install --classic code
	check_successful ?$ "vscode"
	new_small_separator

	for extension in "${extensions[@]}"
	do
		code --install-extension $extension
	done
	new_small_separator
else
	echo_message "vscode cannot be installed on this machine"
fi

# Link settings.json
rm ~/.config/Code/User/settings.json
if [ $? = 0 ]; 
then
	ln -sfv "$(pwd)/../vscode/settings.json" ~/.config/Code/User/
	echo_message "global settings.json file linked to local one"
fi