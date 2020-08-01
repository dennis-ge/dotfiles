!/bin/bash


function read_input {
    read -n1 -r -p " $1 (Y/n) " key
    echo
    if [ "$key" = 'Y' ]; then
        return 0 # True
    else
        return 1 # False
    fi
}

apt=(
    "chromium-browser"
    "python3"
    "python3-pip"
    "curl"
    "git"
    "dconf"
    "vim"
)

for package in "${apt[@]}"
do
    sudo apt-get install -y $package
    echo ">> apt-get install -y $package DONE"
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

gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
echo ">> Dock Bottom DONE"

# Set german keyboard layout
setxkbmap -layout de
echo ">> setxkbmap -layout de DONE"

# JetBrains Products
if read_input "Install PyCharm?"; then
    sudo snap install pycharm-professional --classic
    echo ">> snap install pycharm-professional --classic  DONE"
    pycharm-professional_pycharm-professional.desktop >> favorite_apps.txt
fi

if read_input "Install WebStorm?"; then
    sudo snap install webstorm --classic
    echo ">> snap install webstorm --classic DONE"
    webstorm_webstorm.desktop >> favorite_apps.txt
fi

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


