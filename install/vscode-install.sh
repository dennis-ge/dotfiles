#!/usr/bin/env bash

extensions=(
	"hookyqr.beautify"
	"equinusocio.vsc-community-material-theme"
	"eamodio.gitlens"
	"ms-azuretools.vscode-docker"
	"ms-vscode.vscode-typescript-tslint-plugin"
	"ms-vscode.notepadplusplus-keybindings"
	"ms-python.python"
	"oderwat.indent-rainbow"
	"christian-kohler.path-intellisense"
	"visualstudioexptteam.vscodeintellicode"
	"pkief.material-icon-theme"
	"equinusocio.vsc-material-theme"
)

if is_ubuntu_desktop || is_macos; then
	# Install VS Code
	if is_macos; then
		brew install --cask visual-studio-code
	else 
		sudo snap install --classic code
	fi
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
if is_macos; then
	rm ~/Library/ApplicationSupport/Code/User/settings.json
	cp "$(pwd)/etc/vscode/settings.json" ~/Library/ApplicationSupport/Code/User/
else 
	rm ~/.config/Code/User/settings.json
	cp "$(pwd)/etc/vscode/settings.json" ~/.config/Code/User/
fi
echo_message "global settings.json file linked to local one"
