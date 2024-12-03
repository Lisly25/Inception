#Should use alpine:3.19.4 as the base - that's the penultimate stable version (latest would be 3.20.3)

#Might want to look up how to pin the image version to a specific digest
FROM alpine:3.19.4

#EXPOSE <the port the container/image will expose>
EXPOSE 9000

#WORKDIR <path to working directory - example /usr/local/app>
WORKDIR /var/www/html

#RUN <some command>
#If using debian base, should install things with apt-get update && apt-get install -y <list of packages>
RUN apk update && apk add curl mariadb-client php82 php82-phar php82-fpm php82-mysqli php82-json php82-curl php82-dom php82-mbstring php82-xml php82-openssl php82-session bash

RUN chown -R 1000 /var/www/html

#php82-phar is needed for the wp cli installation


COPY ./tools/wordpress_init_wp_cli.sh /usr/local/bin
COPY ./conf/www.conf /etc/php82/php-fpm.d/www.conf

RUN chmod +x /usr/local/bin/wordpress_init_wp_cli.sh

#Shouldn't be done in the dockerfile, but to check installation:
	#sudo systemctl status php8.2-fpm

#Set-up steps: https://wiki.debian.org/WordPress
#or https://www.ionos.com/digitalguide/hosting/blogs/wordpress-nginx/

#COPY <to copy files from the host - in our case should be /home/login/data on the host machine using Docker>

CMD ["wordpress_init_wp_cli.sh"]