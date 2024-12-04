#Should use alpine:3.19.4 as the base - that's the penultimate stable version (latest would be 3.20.3)

#Might want to look up how to pin the image version to a specific digest
FROM alpine:3.19.4

#WORKDIR <path to working directory - example /usr/local/app>

#EXPOSE <the port the container/image will expose>
EXPOSE 443

RUN apk update && apk add nginx bash openssl

RUN mkdir -p /var/www/html && chown -R 755 /var/www/html

#COPY <to copy files from the host - in our case should be /home/login/data on the host machine using Docker>
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/self-signed.conf /etc/nginx/snippets/self-signed.conf
COPY ./conf/ssl-params.conf /etc/nginx/snippets/ssl-params.conf
COPY ./tools/nginx_start.sh /usr/local/bin/

#RUN <some command>
#If using debian base, should install things with apt-get update && apt-get install -y <list of packages>
#Here I'll probably want
RUN chmod +x /usr/local/bin/nginx_start.sh
#RUN mkdir -p /etc/nginx/ssl

ENTRYPOINT [ "nginx_start.sh" ]