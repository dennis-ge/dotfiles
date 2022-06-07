#!/usr/bin/env bash

extensions=(
	"christian-kohler.path-intellisense"
	"DavidAnson.vscode-markdownlint"
	"dbaeumer.vscode-eslint"
	"donjayamanne.githistory"
	"eamodio.gitlens"
	"esbenp.prettier-vscode"
	"equinusocio.vsc-community-material-theme"
	"equinusocio.vsc-material-theme"
	"GitHub.copilot"
	"golang.go"
	"james-yu.latex-workshop"
	"jebbs.plantuml"
	"ms-python.pylint"
	"ms-python.python"
	"ms-python.vscode-pylance"
	"ms-toolsai.jupyter"
	"ms-toolsai.jupyter-keymap"
	"ms-toolsai.jupyter-renderers"
	"ms-vscode-remote.remote-containers"
	"ms-vscode-remote.remote-ssh"
	"ms-vscode-remote.remote-ssh-edit"
	"ms-vscode.notepadplusplus-keybindings"
	"ms-vsliveshare.vsliveshare"
	"oderwat.indent-rainbow"
	"pkief.material-icon-theme"
	"redhat.vscode-yaml"
	"streetsidesoftware.code-spell-checker"
	"visualstudioexptteam.vscodeintellicode"
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
		code --install-extension "$extension"
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
