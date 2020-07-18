#!/bin/bash

function new_section {
    printf "%0.s-" {1..50}
    printf "\n"
}

function read_input {
    read -n1 -r -p " $1 (Y/n) " key
    echo
    if [ "$key" = 'Y' ]; then
        return 0 # True
    else
        return 1 # False
    fi
}

sed -i -e 's/\r$//' ./docker.sh
sed -i -e 's/\r$//' ./docker-compose.sh
sed -i -e 's/\r$//' ./vscode/settings.sh

echo "Starting Basic Script"
new_section

apt=(
    "chromium-browser"
    "python3"
    "python3-pip"
    "sqlitebrowser"
    "curl"
    "git"
    "dconf"
    "vim"
)

for package in "${apt[@]}"
do
    sudo apt-get install -y $package
    echo ">> apt-get install -y $package DONE"
    new_section
done

snap=(
    "postman"
    "code"
)
for package in "${snap[@]}"
do
    sudo snap install --classic $package
    echo ">> snap install $package --classic DONE"
    new_section
done

# VS Code Settings
chmod +x ./vscode/settings.sh
./vscode/settings.sh
echo ">> ./vscode/settings.sh DONE"
new_section

# Small Configuration Changes

# Set py as default
echo "alias py=python3" >> ~/.bashrc
echo ">> alias py=python3 >> ~/.bashrc DONE"
new_section
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
echo ">> Dock Bottom DONE"
new_section
# Set german keyboard layout
setxkbmap -layout de
echo ">> setxkbmap -layout de DONE"
new_section

echo ">> git config DONE"
new_section


# JetBrains Products
if read_input "Install PyCharm?"; then
    sudo snap install pycharm-professional --classic
    echo ">> snap install pycharm-professional --classic  DONE"
    pycharm-professional_pycharm-professional.desktop >> favorite_apps.txt
    new_section
fi

if read_input "Install WebStorm?"; then
    sudo snap install webstorm --classic
    echo ">> snap install webstorm --classic DONE"
    webstorm_webstorm.desktop >> favorite_apps.txt
    new_section
fi

if read_input "Install Go and Golang?"; then
    sudo snap install go --classic
    echo ">> snap install go --classic DONE"
    new_section
    sudo snap install goland --classic
    echo ">> snap install goland --classic DONE"
    new_section
fi

#Docker and Docker-Compose
if read_input "Install Docker?"; then
    chmod +x ./docker.sh
    ./docker.sh
    echo ">> ./docker.sh DONE"
    new_section
fi

if read_input "Install Docker-Compose?"; then
    chmod +x ./docker-compose.sh
    ./docker-compose.sh
    echo ">> ./docker-compose.sh DONE"
    new_section
fi

# Update Favorite Apps
VALUE=$(/usr/bin/python3 favorite_apps/main.py 2>&1 > /dev/null)
dconf write /org/gnome/shell/favorite-apps "$VALUE"

# Remove Applications

to_delete_apt=(
    "libreoffice*"
    "rhytmbox"
    "deja-dup"
    "gnome-calculator"
    "shotwell*"
)
for package in "${to_delete_apt[@]}"
do
    sudo apt-get remove $package
    sudo apt-get clean
    sudo apt-get autoremove
    echo ">> Removed $package DONE"
    new_section
done


echo "Basic Script finished"
