#!/bin/bash

echo "Starting Basic Script"
printf "%0.s-" {1..50}
printf "\n"
#setxkbmap -layout de
echo ">> setxkbmap -layout de DONE"


apt=(
    "chromium-browser"
    "python3"
    "python3-pip"

)

for package in "${apt[@]}"
do
    sudo apt-get install -y $package
    echo ">> apt-get install -y $package DONE"
    printf "%0.s-" {1..50}
    printf "\n"
done


echo "Basic Script finished"

