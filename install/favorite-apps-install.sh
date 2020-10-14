#!/usr/bin/env bash

# Abort if the System is not Ubuntu Desktop
is_ubuntu_desktop || exit 1

# Update Favorite Apps
FAVORITE_APPS=$(/usr/bin/python3 $(pwd)/etc/favorite_apps/main.py 2>&1 > /dev/null)
check_successful $? "Favorite Apps"
