FROM alpine:3.20.3

EXPOSE 3306

COPY ./tools/mariadb_setup.sh /usr/local/bin/
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

RUN apk update && apk add mariadb mariadb-client mariadb-common bash

RUN chmod +x /usr/local/bin/mariadb_setup.sh

RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld
RUN mkdir -p /var/log/mysql && chown -R mysql:mysql /var/log/mysql

ENTRYPOINT [ "mariadb_setup.sh" ]