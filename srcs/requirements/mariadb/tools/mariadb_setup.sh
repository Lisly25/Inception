#!/bin/bash

echo "Executing setup script"

echo "Initializing mariaDB data directory and creating system tables"

if test -d "/var/lib/mysql/mysql"; then
	echo "MariaDB already initialized"
else
	mariadb_install_db --datadir=/var/lib/mysql --user=mysql
	echo "Waiting for database to be initialized..."
	mariadbd --user=mysql --bootstrap << EOF
FLUSH PRIVILAGES
EOF
	echo "Database initialized. Setting up database and accounts..."
	
fi

exec mariadbd_safe
