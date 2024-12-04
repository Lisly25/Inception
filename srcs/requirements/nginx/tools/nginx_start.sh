#!/bin/bash

# https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu

echo "Checking if ssl certificate is present"

if test -f $CERTS_KEY; then
	echo "Certificate already generated"
else
	echo "No certificate. Generating..."
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $CERTS_KEY \
	 -out $CERTS_CRT -subj "/CN=$DOMAIN_NAME"

	#echo "Generating dh parameters - this will take a while"
	#openssl dhparam -out /etc/nginx/dhparam.pem 4096
	echo "Certificate successfully generated"

	#echo "Adding certificate location info to self-signed.conf"

	#echo  "ssl_certificate $CERTS_CRT;" >> /etc/nginx/snippets/self-signed.conf
	#echo "ssl_certificate_key $CERTS_KEY;" >> /etc/nginx/snippets/self-signed.conf

fi

echo "Nginx configuration done. Starting nginx"

#Replaces current process with nginx (running in the foreground), becoming PID 1
exec nginx -g 'daemon off;'
