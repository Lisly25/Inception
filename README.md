# INCEPTION

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