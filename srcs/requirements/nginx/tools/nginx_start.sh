#!/bin/bash

# https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu

echo "Checking if ssl certificate is present"

if test /etc/ssl/private/nginx-selfsigned.key
	echo "Certificate already generated"
else
	echo "No certificate. Generating..."
	sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key \
	 -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/CN=$DOMAIN_NAME"
	sudo openssl dhparam -out /etc/nginx/dhparam.pem 4096
	echo "Certificate successfully generated"
fi


#Replaces current process with nginx (running in the foreground), becoming PID 1
exec nginx -g 'daemon off;'