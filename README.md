# INCEPTION

This is a project in the curriculum of Hive Helsinki / the 42 network. The main goal of this was to learn about docker and containers. The end result is a website.

## How to use

You will need sudo permissions to use this program. If it is not available to you, you will need to set up a virtual machine first.

1. Make sure that docker is installed on your system. If it is, using the following command should behave like this:

```bash
$ docker --version
Docker version 26.1.4, build 5650f9b
```

2. Then, add your user to the "docker" group:

```bash
$ sudo usermod -aG docker $USER
```
(If the docker group does not exist, you can create it with the below command:)

```bash
$ sudo groupadd docker
```

3. Clone this repository, navigate inside it, and use the 'make' command

```bash
$ git clone git@github.com:Lisly25/Inception.git Inception && cd Inception && make
```

The start-up process will take some time. You might also be prompted to enter your password. This is required to create the directory to hold the volumes for the mariadb and wordpress containers, and add the domain name to the /etc/hosts file

4. The website can now be visited at https://skorbai.42.fr (Note that even after step 3. finishes, it might take some time for the website to become available)

Note for usage on Windows/WSL:

For the domain name to be recognized, this line has to be added to ` c:\windows\system32\drivers\etc\hosts `

```
	127.0.0.1	skorbai.42.fr
```

## How to stop the program

### Suspending the program

Use the 'make down' command at the root of the repository

```bash
$ make down
```

This will just execute the docker compose down command. The wordpress website's files and the database contents will persist

### Remove the volumes

Using the 'make clean' command at the root of the repository will suspend the program, and removed the website files as well as the database contents (by removing the docker volumes from the host machine)

```bash
$ make clean
```

### Complete clean-up

Use the 'make fclean' command at the root of the repository to remove all files that the program added, reclaiming all memory that has been used

```bash
$ make fclean
```

## About the project

The fundamental idea is that the website is ran with the help of three docker containers. One of them is responsible for handling the database, another is for creating the wordpress website, while the third is hosting the website with nginx.

The database and the wordpress website's files mustn't be lost every time the system is restarted, so they are stored in docker volumes

```mermaid
	flowchart LR
		classDef Container fill:#395480,stroke:#333,stroke-width:4px
		classDef Volume fill:#215e1b,stroke:#333,stroke-width:4px
		subgraph "**Host machine**"
		subgraph "**Docker containers**"
		A[MariaDB<br/>container] <-->|port 3306| B(WordPress<br/>container)
		B <-->|port 9000| C[nginx<br/>container]
		class A Container
		class B Container
		class C Container
		end
		E@{ shape: cyl, label: "MariaDB<br/> volume" } <--> A
		F@{ shape: cyl, label: WordPress<br/> volume } <--> B
		F <---> C
		class E Volume
		class F Volume
		end
			C <-->|port 443| D@{ shape: diamond, label: WWW }
```

### Docker compose file

Since the program requires three containers to work together, a docker compose was used to set it up.

The three containers are configured as three services. 

```yml
services:

	mariadb:
		container_name: mariadb
		build:
			context: ./requirements/mariadb
			dockerfile: Dockerfile
		image: mariadb:skorbai #The tag is important - otherwise, the official image would be pulled from dockerhub
		ports:
			- 3306
		env_file:
			- ".env"
		volumes:
			- DB:/var/lib/mysql
		networks:
			- inception_network #All three services will be part of this
		restart: always
```

```yml
	wordpress:
		container_name: wordpress
		build:
			context: ./requirements/wordpress
			dockerfile: Dockerfile
		image: wordpress:skorbai
		depends_on: #Determines the startup order of the containers
			- mariadb
			- nginx
		env_file:
			- ".env"
		volumes:
			- WordPress:/var/www/html
		networks:
			- inception_network
		restart: on-failure
```

## Useful docker commands for debugging

To show the complete log of the stdout of the container:

```bash
$ docker logs \<container_name\>
```

To run a command inside the container in interactive mode:

```bash
$ docker exec -it \<container_name\> \<command\>
```

This command can be `mysql` for example, to check the mariadb database, or even bash

To look at the logs from nginx, you first have to use the above command to get a shell from the container

With my configuration, this is where the error and access log are found (this is the default), but this is something that can be changed in the nginx configuration file

```bash
$ docker exec -it nginx bash
$ cd /var/log/nginx
```

## MariaDB cheat sheet

Some basic commands to verify that the database has been set up correctly

Show list of databases:

```
SHOW DATABASES;
```

To work on a specific database:

```
USE <database>
```

To list the tables in a database (make sure to use the USE command first):

```
SHOW TABLES;
```

To look at all the entries in a database:

```
SELECT * FROM <table>;
```