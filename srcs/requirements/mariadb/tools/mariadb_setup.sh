#!/bin/bash

#To make the script exit if any command exits with status that is NOT 0
set -e

config_file="/etc/my.cnf/mariadb.cnf"

echo "Checking if MariaDB option file is present at $config_file"

test $config_file

echo "Editing the MariaDB Option file at $config_file"

echo "[mysqld]" >> $config_file

#Make server listen on all IP addresses
echo "bind-address=0.0.0.0" >> $config_file
#Enables networking
echo "skip-networking=0" >> $config_file
