#!/bin/bash


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
    echo ">> code --install-extension $extension  DONE"
done

# Copy settings.json

rm ~/.config/Code/User/settings.json
cp ./vscode/settings.json ~/.config/Code/User/
echo ">> update VSCode Settings  DONE"