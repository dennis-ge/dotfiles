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

echo "Starting Basic Script"
new_section

apt=(
    "chromium-browser"
    "python3"
    "python3-pip"
    "sqlitebrowser"
    "curl"
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

# Small Configuration Changes

# Set py as default
echo "alias py=python3" >> ~/.bashrc
echo ">> alias py=python3 >> ~/.bashrc DONE"
new_section

# Set german keyboard layout
setxkbmap -layout de
echo ">> setxkbmap -layout de DONE"
new_section

# JetBrains Products
if read_input "Install PyCharm?"; then
    sudo snap install pycharm-professional --classic
    echo ">> snap install pycharm-professional --classic  DONE"
    new_section
fi

if read_input "Install WebStorm?"; then
    sudo snap install webstorm --classic
    echo ">> snap install webstorm --classic DONE"
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
fi

if read_input "Install Docker-Compose?"; then
    chmod +x ./docker-compose.sh
    ./docker-compose.sh
    echo ">> ./docker.sh DONE"
fi

echo "Basic Script finished"

