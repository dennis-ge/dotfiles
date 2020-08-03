#!/bin/bash

# Abort if the System is not Ubuntu Desktop
is_ubuntu_desktop || return 1

# Update Favorite Apps
FAVORITE_APPS=$(/usr/bin/python3 /../etc/favorite_apps/main.py 2>&1 > /dev/null)
dconf write /org/gnome/shell/favorite-apps "$FAVORITE_APPS"
if [ $? = 0 ]; 
then
	echo_message  "Favorite Apps updated"
else
    echo_error "Favorite Apps update failed"
fi
