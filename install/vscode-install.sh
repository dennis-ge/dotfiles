#!/bin/bash

# Install VS Code
sudo snap install --classic code

extensions=(
    "ms-azuretools.vscode-docker"
    "ms-vscode.vscode-typescript-tslint-plugin"
    "hookyqr.beautify"
    "ms-python.python"
    "christian-kohler.path-intellisense"
    "visualstudioexptteam.vscodeintellicode"
)

for extension in "${extensions[@]}"
do
    code --install-extension $extension
done
echo "The following settings have been installed: "
code --list-extensions

# Copy settings.json
rm ~/.config/Code/User/settings.json
cp ./vscode/settings.json ~/.config/Code/User/
