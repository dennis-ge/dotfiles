#!/bin/bash

function new_section {
    printf "%0.s-" {1..50}
    printf "\n"
}

echo "Starting Basic Script"
new_section

apt=(
    "chromium-browser"
    "python3"
    "python3-pip"
    "sqlitebrowser"
)

for package in "${apt[@]}"
do
   # sudo apt-get install -y $package
    echo ">> apt-get install -y $package DONE"
    new_section
done

snap=(
    "postman"
    "code"
)
for package in "${snap[@]}"
do
   # sudo snap install --classic $package
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

# Elasticsearch development
read -n1 -r -p "Elasticsearch development? (Y/n) " key
echo
if [ "$key" = 'Y' ]; then
    sudo -i
    echo "vm.max_map_count=262144" >> /etc/sysctl.conf
    exit
    echo "vm.max_map_count=262144 >>/etc/sysctl.conf DONE"
    new_section
fi
# JetBrains Products
read -n1 -r -p "Install PyCharm? (Y/n) " key
echo
if [ "$key" = 'Y' ]; then
    sudo snap install pycharm-professional --classic
    echo ">> snap install pycharm-professional --classic  DONE"
    new_section
fi

read -n1 -r -p "Install WebStorm? (Y/n) " key
echo
if [ "$key" = 'Y' ]; then
    sudo snap install webstorm --classic
    echo ">> snap install webstorm --classic DONE"
    new_section
fi

read -n1 -r -p "Install Go and Golang? (Y/n) " key
echo
if [ "$key" = 'Y' ]; then
    sudo snap install go --classic
    echo ">> snap install go --classic DONE"
    new_section
    sudo snap install goland --classic
    echo ">> snap install goland --classic DONE"
    new_section
fi

echo "Basic Script finished"

