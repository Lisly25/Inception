#Must set up the entire application

#Using docker-compose.yml

#And actually calling the Dockerfiles in docker-compose.yml?

#https://www.docker.com/blog/containerizing-test-tooling-creating-your-dockerfile-and-makefile/

NAME = Inception

DOCKERFILES = srcs/requirements/mariadb/Dockerfile \
				srcs/requirements/nginx/Dockerfile \
				srcs/requirements/wordpress/Dockerfile

DOCKER_COMPOSE_FILE = srcs/docker-compose.yml

SETUP_SCRIPT = srcs/requirements/tools/project_setup.sh
CLEANUP_SCRIPT = srcs/requirements/tools/project_cleanup.sh

#https://www.codecademy.com/article/mastering-docker-compose

$(NAME):	$(DOCKERFILES) $(SETUP_SCRIPT) $(DOCKER_COMPOSE_FILE)
	./$(SETUP_SCRIPT)
	cd srcs && docker compose up -d

down:
	cd srcs && docker compose down

clean:	$(CLEANUP_SCRIPT)
	make down
	./$(CLEANUP_SCRIPT)

fclean:
	make clean
	docker system prune --force -a --volumes

all:
	make $(NAME)

re:
	make fclean
	make all
