#!/bin/bash

echo "Cleaning up mariadb and wordpress volumes"

sudo rm -rf /home/skorbai/data

echo "Removing website domain name from /etc/hosts"

#/etc/host also contains this line
#127.0.1.1	Inception.skorbai.42.fr Inception
#which we DO NOT want to remove
#hence the regex below looks for lines ENDING with the pattern

sudo gawk -i inplace '!/skorbai.42.fr$/' /etc/hosts