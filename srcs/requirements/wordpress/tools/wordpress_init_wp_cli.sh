#!/bin/bash

#https://make.wordpress.org/cli/handbook/how-to/how-to-install/

echo "Downloading WP-CLI"

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#Need to check the installation - recommended way is "php wp-cli.phar --info"

echo "Creating WP-CLI command utility"

chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

echo "Checking WP-CLI installation"

wp --info

#Need to check what happens if it isn't installed

echo "Downloading wordpress"

#Will download it to the current working directory into a wordpress folder
wp core download --path=wordpress

echo "Generating wordpress config file"

#Not sure if I should specify the --dbname --dbuser and --dbpass options here

wp config create

#Even less sure about needing this

#wp db create

echo "Installing wordpress"

wp core install --url=skorbai.42.fr --title="Inception" --admin_user=$WP_ROOT_USER --admin_password=$WP_PASS

echo "Starting the server"

#Not sure if this needs to be done here since we're also using nginx

#wp server --port=443 --host