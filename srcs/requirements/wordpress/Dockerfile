FROM alpine:3.20.3

EXPOSE 9000

WORKDIR /var/www/html

RUN apk update && apk add curl mariadb-client php83 php83-phar php83-fpm php83-mysqli php83-json php83-curl php83-dom php83-mbstring php83-xml php83-openssl php83-session bash

RUN chown -R 755 /var/www/html

COPY ./tools/wordpress_init_wp_cli.sh /usr/local/bin
COPY ./conf/www.conf /etc/php83/php-fpm.d/www.conf

RUN chmod +x /usr/local/bin/wordpress_init_wp_cli.sh

ENTRYPOINT ["wordpress_init_wp_cli.sh"]