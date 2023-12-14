NAME 			:= inception
DOCKER-COMPOSE 	:= ./srcs/docker-compose.yml
ENV_FILE := ./srcs/.env
VOLUMES_DIR := /home/jmouaike42/data

all: build

build: setup
	docker compose -f $(DOCKER-COMPOSE) --env-file $(ENV_FILE) up -d --build

start:
	docker compose -f $(DOCKER-COMPOSE) start

# containers stopped
stop:
	docker compose -f $(DOCKER-COMPOSE) stop


# containers and network stopped
down:
	docker compose -f $(DOCKER-COMPOSE) down 

# List containers. -a all 
ps:
	docker ps

clean: stop
	docker compose -f $(DOCKER-COMPOSE) down

fclean: clean
# Remove one or more images. -f Force removal of the image
	docker rmi -f $$(docker images -qa) >> /dev/null
# docker volume rm $$(docker volume ls) >> /dev/null
# docker network rm $$(docker network ls) >> /dev/null

prune: down
	docker image prune -a
	sudo rm -rf $(VOLUMES_DIR)
	# docker compose -f $(VOLUMES_DIR) down --remove-orphans
	# docker compose -f $(VOLUMES_DIR) down --volumes
	# docker compose rm -f

re: fclean all
	

images:
	docker images -qa

network:
	docker network ls

volume:
	docker volume ls

logs:
	docker logs -t -f $$(docker compose -f $(DOCKER-COMPOSE) ps -q nginx)

test:
	wget --spider -S https://jmouaike.42.fr --no-check certificate

setup:
	mkdir -p $(VOLUMES_DIR)/website
	mkdir -p $(VOLUMES_DIR)/database


.PHONY: all setup build start stop down ps clean fclean re images network volume logs test