#!/bin/bash

until mysql --host=mariadb --user=$MYSQL_USER --password=$MYSQL_PASSWORD --execute="SELECT 1"; do
    echo "Waiting for database to start up"
    sleep 3
done

if test -f wp-config.php; then
    echo "Wordpress has already been set up"
else
    echo "Downloading WP-CLI"

    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

    echo "Creating WP-CLI command utility"

    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    echo "Checking WP-CLI installation"

    wp --info

    if [ $? -eq 0 ]; then
        echo "WP-CLI successfully installed"
    else
        echo "WP-CLI installation failed. Exiting..."
        exit 1
    fi

    echo "Downloading wordpress"

    wp core download --allow-root

    echo "Generating wordpress config file"


    wp config create --allow-root --dbhost=mariadb --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD

    echo "Installing wordpress"

    wp core install --url=$DOMAIN_NAME --title="Inception" --admin_user=$WP_ADMIN_USERNAME --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --allow-root

    echo "Checking if the normal user already exists"

    if wp user get "$WP_NORMAL_USERNAME" --allow-root; then
        echo "User already exists"
    else
        echo "No such user yet. Adding it now"
        wp user create "$WP_NORMAL_USERNAME" "$WP_NORMAL_EMAIL" --role=author --user_pass="$WP_NORMAL_PASS" --allow-root
    fi

    chmod o+w -R /var/www/html/wp-content

    echo "Starting the server"
    
fi

exec php-fpm82 -F
