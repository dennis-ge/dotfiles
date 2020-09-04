#!/bin/bash

wget -P ~/ --no-hsts https://dl.google.com/go/go1.15.linux-amd64.tar.gz 

sudo tar -C /usr/local -xzf ~/go1.15.linux-amd64.tar.gz
source ~/.go
go version
check_successful $? "Go 1.15"
