#!/bin/bash

if ! test -f wp-config.php; then
    echo "First run. Editing PHP-FPM configuration file to allow connections from other containers"
    sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php82/php-fpm.d/www.conf
    echo "Contents of the configuration file after editing:"
    cat /etc/php82/php-fpm.d/www.conf
fi

#Error when trying the below step: "ERROR 2005 (HY000): Unknown server host 'mariadb' (-2) "
#Maybe solution? https://www.basedash.com/blog/how-to-fix-error-2005-hy000-unknown-mysql-server-host

until mysql --host=mariadb --user=$MYSQL_USER --password=$MYSQL_PASSWORD --execute="SELECT 1"; do
    echo "Waiting for database to start up"
    sleep 3
done

#mariadb-admin ping --protocol=tcp --host=mariadb -u "$MYSQL_USER" --password="$MYSQL_PASSWORD" --wait

#https://make.wordpress.org/cli/handbook/how-to/how-to-install/

if test -f wp-config.php; then
    echo "Wordpress has already been set up"
else
    echo "Downloading WP-CLI"

    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

    #Need to check the installation - recommended way is "php wp-cli.phar --info"

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

    #Need to check what happens if it isn't installed

    echo "Downloading wordpress"

    #Will download it to the current working directory into a wordpress folder
    wp core download --allow-root

    echo "Generating wordpress config file"

    #Not sure if I should specify the --dbname --dbuser and --dbpass options here

    wp config create --allow-root --dbhost=mariadb --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD

    #Even less sure about needing this

    #wp db create

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

    #Not sure if this needs to be done here since we're also using nginx
    
fi

exec php-fpm82 -F
