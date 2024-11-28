#!/bin/bash

#Create directory where volumes will be placed

if test -d /home/skorbai/data/wordpress; then
	echo "Wordpress volume already exists"
else
	echo "Wordpress volume not created yet. Making directory now"
	mkdir /home/skorbai/data/wordpress
	sudo chown -R 1000 /home/skorbai/data/wordpress
fi

if test -d /home/skorbai/data/database; then
	echo "Database volume already exists"
else
	echo "Database volume not created yet. Making directory now"
	mkdir /home/skorbai/data/wordpress
	sudo chown -R 1000 /home/skorbai/data/wordpress
fi