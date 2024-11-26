#Should use alpine:3.19.4 as the base - that's the penultimate stable version (latest would be 3.20.3)

#Might want to look up how to pin the image version to a specific digest
FROM alpine:3.19.4

#WORKDIR <path to working directory - example /usr/local/app>

#RUN <some command>
#If using debian base, should install things with apt-get update && apt-get install -y <list of packages>
#apk update && apk add (((wordpress))) curl php-fpm bash

#Shouldn't be done in the dockerfile, but to check installation:
	#sudo systemctl status php8.2-fpm

#Set-up steps: https://wiki.debian.org/WordPress
#or https://www.ionos.com/digitalguide/hosting/blogs/wordpress-nginx/

#COPY <to copy files from the host - in our case should be /home/login/data on the host machine using Docker>

#EXPOSE <the port the container/image will expose>
EXPOSE 9000