#!/bin/bash

echo "Executing setup script"

echo "Initializing mariaDB data directory and creating system tables"

if test -d "/var/lib/mysql/mysql"; then
	echo "MariaDB already initialized"
else
	mysql_install_db --datadir=/var/lib/mysql --group=mysql --user=mysql --skip-test-db --auth-root-authentication-method=socket
	echo "Initialization started. Creating database..."
	mysqld --user=mysql --bootstrap << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
GRANT ALL PRIVILEGES ON *.* to 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF
	echo "Database \" $MYSQL_DATABASE \" has been created successfully"
	
fi

echo "Starting server"

#Executing the script this way makes sure that this process replaces the current process (Thus it will be PID 1)
exec mysqld --user=mysql
