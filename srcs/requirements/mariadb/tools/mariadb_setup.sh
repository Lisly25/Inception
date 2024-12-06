#!/bin/bash

echo "Executing setup script"

echo "Initializing mariaDB data directory and creating system tables"

if test -d "/var/lib/mysql/mysql"; then
	echo "MariaDB already initialized"
else
	mysql_install_db --datadir=/var/lib/mysql --user=mysql --skip-test-db
	echo "Initialization started. Creating database..."
	mysqld --user=mysql --bootstrap << EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF
	echo "Database \" $MYSQL_DATABASE \" has been created successfully"
	
fi

echo "Starting server"

#Executing the script this way makes sure that this process replaces the current process (Thus it will be PID 1)
exec mysqld --user=mysql
