#!/bin/bash

new_separator() {
	printf "%0.s-" {1..25}
	printf "\n"
}
extensions=(
	"ms-azuretools.vscode-docker"
	"ms-vscode.vscode-typescript-tslint-plugin"
	"hookyqr.beautify"
	"ms-python.python"
	"christian-kohler.path-intellisense"
	"visualstudioexptteam.vscodeintellicode"
)

# Install VS Code
sudo snap install --classic code

if [ $? = 0 ];
then
	tput setaf 2; echo "vscode successfully installed"; tput sgr0
    new_separator

	for extension in "${extensions[@]}"
	do
		code --install-extension $extension
	done
	tput setaf 2; echo "The following settings have been installed:"; tput sgr0;
	code --list-extensions

	# Copy settings.json
	rm ~/.config/Code/User/settings.json
	ln -sfv /../vscode/settings.json ~/.config/Code/User/
    tput setaf 2; echo "global settings.json file linked to local one"; tput sgr0
else
    tput setaf 1; echo "ERROR: vscode  installation failed"; tput sgr0
fi
