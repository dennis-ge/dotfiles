print_message() {
	tput setaf 2; echo $1; tput sgr0
}

print_error() {
	tput setaf 1; echo $1; tput sgr0
}

new_separator() {
	printf "%0.s-" {1..25}
	printf "\n"
}

read_input {
	read -n1 -r -p " $1 (Y/n) " key
	echo
	if [ "$key" = 'Y' ]; then
		return 0 # True
	else
        	return 1 # False
	fi
}

# JetBrains Products
if read_input "Install PyCharm?"; then
	sudo snap install pycharm-professional --classic
	if [ $? = 0 ]; 
	then
		print_message "PyCharm Professional successfully installed"
    	else
		print_error "ERROR: Pycharm Proffessional installation failed"
	fi
	new_separator
	pycharm-professional_pycharm-professional.desktop >> ../etc/favorite_apps/favorite_apps.txt
fi

if read_input "Install WebStorm?"; then
	sudo snap install webstorm --classic
	if [ $? = 0 ]; 
	then
		print_message "Webstorm successfully installed"
    	else
		print_error "ERROR: Webstorm installation failed"
	fi
	new_separator
	webstorm_webstorm.desktop >> ../etc/favorite_apps/favorite_apps.txt
fi