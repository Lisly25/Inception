FROM alpine:3.20.3

EXPOSE 9000

WORKDIR /var/www/html

RUN apk update && apk add curl mariadb-client php82 php82-phar php82-fpm php82-mysqli php82-json php82-curl php82-dom php82-mbstring php82-xml php82-openssl php82-session bash

RUN chown -R 755 /var/www/html

COPY ./tools/wordpress_init_wp_cli.sh /usr/local/bin
COPY ./conf/www.conf /etc/php82/php-fpm.d/www.conf

RUN chmod +x /usr/local/bin/wordpress_init_wp_cli.sh

ENTRYPOINT ["wordpress_init_wp_cli.sh"]