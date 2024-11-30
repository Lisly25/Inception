#Should use alpine:3.19.4 as the base - that's the penultimate stable version (latest would be 3.20.3)

#Might want to look up how to pin the image version to a specific digest
FROM alpine:3.19.4

#https://mariadb.com/kb/en/creating-a-custom-container-image/

#WORKDIR <path to working directory - example /usr/local/app>

#EXPOSE <the port the container/image will expose>
EXPOSE 3306

#COPY <to copy files from the host - in our case should be /home/login/data on the host machine using Docker>
#COPY conf/init.sql /tmp/init.sql
COPY ./tools/mariadb_setup.sh /usr/local/bin/
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

#RUN <some command>
#If using debian base, should install things with apt-get update && apt-get install -y <list of packages>
RUN apk update && apk add mariadb mariadb-client mariadb-common bash

RUN chmod +x /usr/local/bin/mariadb_setup.sh
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

#Not sure if the syntax is right
ENTRYPOINT [ "mariadb_setup.sh" ]

# This health check makes a simple query to ensure the database can answer requests (and uses a system variable, we don't want to assume that there's already user created tables)
# Can be only one health check - if there were multiple, only the last one would be executed


#HEALTHCHECK --start-period=5m \
#  CMD mariadb -e 'SELECT @@datadir;' || exit 1
CMD ["mysqld", "--user=mysql"]

#To actually start the database (not sure if I need to do it here with docker compose and all)
#CMD ["mariadb"]
#CMD ["mysqld", "--user=mysql", "--init-file=/tmp/init.sql"]
#CMD ["mariadbd-safe"]
