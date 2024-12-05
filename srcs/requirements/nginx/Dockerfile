FROM alpine:3.19.4

EXPOSE 443

RUN apk update && apk add nginx bash openssl

RUN mkdir -p /var/www/html && chown -R 755 /var/www/html

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/self-signed.conf /etc/nginx/snippets/self-signed.conf
COPY ./conf/ssl-params.conf /etc/nginx/snippets/ssl-params.conf
COPY ./tools/nginx_start.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/nginx_start.sh

ENTRYPOINT [ "nginx_start.sh" ]