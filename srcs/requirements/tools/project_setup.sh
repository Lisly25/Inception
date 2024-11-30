#!/bin/bash

#Create directory where volumes will be placed

#TODO: add 127.0.0.1	$DOMAIN_NAME	to /etc/hosts if not there already

if test -d /home/skorbai/data/wordpress; then
	echo "Wordpress volume already exists"
else
	echo "Wordpress volume not created yet. Making directory now"
	sudo mkdir -p /home/skorbai/data/wordpress
	sudo chown -R 1000 /home/skorbai/data/wordpress
fi

if test -d /home/skorbai/data/database; then
	echo "Database volume already exists"
else
	echo "Database volume not created yet. Making directory now"
	sudo mkdir -p /home/skorbai/data/database
	sudo chown -R 1000 /home/skorbai/data/wordpress
fi