#!/bin/bash

#Setting up the website via command line: https://make.wordpress.org/cli/handbook/how-to/how-to-install/

echo "Checking php-fpm installation"

#sudo systemctl status php8.2-fpm #Check the version!

#the -q flag is used to check for the exit code of the command.

if (systemctl -q is-active php8.2-fpm); then
	echo "php-fpm installation was successful"
else
	echo "php-fpm installation was unsuccesful"
fi


echo "Installing the content management system for wordpress"

#Name should be the domain name (just a recommendation, though)

#First check if it already exists

if test -d /var/www/html/skorbai.42.fr; then
	echo "Content management system for wordpress already installed"
else
	echo "Content management system not yet installed. Installing..."
	#-p flag ensures that parent directories will also be created if they don't exist
	# sudo mkdir -p /var/www/html/skorbai.42.fr
	# cd /var/www/html/skorbai.42.fr
	# wget https://wordpress.org/wordpress-6.7.1.tar.gz
	# For this version, Recommend PHP 7.4 or greater and MariaDB version 10.5 or greater.
	# tar -xzf wordpress-6.7.1.tar.gz
	# Need to give nginx authorization for this volume - not sure where to do it
	# sudo chown -R nginx: /var/www/html/example.com/
	# Set up the config file - first, just make one from the sample
	# sudo cp wp-config-sample.php wp-config.php
fi


