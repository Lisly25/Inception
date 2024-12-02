# INCEPTION

This is a project in the curriculum of Hive Helsinki / the 42 network. The main goal of this was to learn about docker and containers. 

## How to use

You will need sudo permissions to use this program. If it is not available to you, you will need to set up a virtual machine first.

1. Make sure that docker is installed on your system. If it is, using the following command should behave like this:

```bash
	% docker --version
	Docker version 26.1.4, build 5650f9b
```

2. Then, add your user to the "docker" group:

```bash
	% sudo usermod -aG docker $USER
```
(If the docker group does not exist, you can create it with the below command:)

```bash
	% sudo groupadd docker
```

3. Clone this repository, navigate inside it, and use the 'make' command

```bash
	% git clone git@github.com:Lisly25/Inception.git Inception && cd Inception && make
```

The start-up process will take some time. You might also be prompted to enter your password. This is required to create the directory to hold the volumes for the mariadb and wordpress containers, and add the domain name to the /etc/hosts file