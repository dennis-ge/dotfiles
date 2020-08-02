# Update Favorite Apps
FAVORITE_APPS=$(/usr/bin/python3 /../etc/favorite_apps/main.py 2>&1 > /dev/null)
dconf write /org/gnome/shell/favorite-apps "$FAVORITE_APPS"
if [ $? = 0 ]; 
then
	tput setaf 2; echo  "Favorite Apps updated"; tput sgr0
else
    tput setaf 1; echo  "Favorite Apps update failed"; tput sgr0
fi
