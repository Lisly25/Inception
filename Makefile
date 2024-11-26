#Must set up the entire application

#Using docker-compose.yml

#And actually calling the Dockerfiles in docker-compose.yml?

#https://www.docker.com/blog/containerizing-test-tooling-creating-your-dockerfile-and-makefile/

DOCKERFILES = srcs/requirements/mariadb/Dockerfile \
				srcs/requirements/nginx/Dockerfile \
				srcs/requirements/wordpress/Dockerfile

#https://www.codecademy.com/article/mastering-docker-compose

#cd srcs && docker compose up -d #-d just means detached mode - it'll keep running in the background, freeing up the terminal

#cd srcs && docker compose down
#rm -rf /home/skorbai/data