#!/bin/bash

echo "Checking for wordpress wolume"

if test -d /home/skorbai/data/wordpress; then
	echo "Wordpress volume already exists"
else
	echo "Wordpress volume not created yet. Making directory now"
	sudo mkdir -p /home/skorbai/data/wordpress
	sudo chown -R 1000 /home/skorbai/data/wordpress
fi

echo "Checking for mariadb volume"

if test -d /home/skorbai/data/database; then
	echo "Database volume already exists"
else
	echo "Database volume not created yet. Making directory now"
	sudo mkdir -p /home/skorbai/data/database
	sudo chown -R 1000 /home/skorbai/data/wordpress
fi

echo "Checking for website domain name in /etc/hosts"

#/etc/host also contains this line
#127.0.1.1	Inception.skorbai.42.fr Inception
#which is NOT what we are looking for
#hence the regex below looks for lines ENDING with the pattern


if grep skorbai.42.fr$ < /etc/hosts; then
	echo "Website domain name is already listed in /etc/hosts"
else
	echo "Website domain name not yet listed in /etc/hosts. Adding now"
	sudo echo "127.0.0.1		skorbai.42.fr" >> /etc/hosts
fi