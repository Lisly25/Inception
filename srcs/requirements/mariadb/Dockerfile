#Should use alpine:3.19.4 as the base - that's the penultimate stable version (latest would be 3.20.3)

#Might want to look up how to pin the image version to a specific digest
FROM alpine:3.19.4

#https://mariadb.com/kb/en/creating-a-custom-container-image/

#WORKDIR <path to working directory - example /usr/local/app>

#RUN <some command>
#If using debian base, should install things with apt-get update && apt-get install -y <list of packages>
#apt-get update && apt-get install -y mariadb-server

#ARG CONFIG_FILE

#COPY <to copy files from the host - in our case should be /home/login/data on the host machine using Docker>

#EXPOSE <the port the container/image will expose>
#EXPOSE 3306

# This health check makes a simple query to ensure the database can answer requests (and uses a system variable, we don't want to assume that there's already user created tables)
# Can be only one health check - if there were multiple, only the last one would be executed

#Not sure if the syntax is right
#ENTRYPOINT [ "./tools/mariadb_setup.sh" ]

#HEALTHCHECK --start-period=5m \
#  CMD mariadb -e 'SELECT @@datadir;' || exit 1

#To actually start the database (not sure if I need to do it here with docker compose and all)
#CMD ["mariadb"]