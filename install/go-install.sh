#!/bin/bash

sudo apt-get install golang 
if [ $? = 0 ]; 
then
	echo_message "Go successfully installed"
	new_small_separator

else
	echo_error "Go installation failed"
fi
