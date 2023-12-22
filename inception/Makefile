#############################################################
# Makefile for inception
#############################################################

NAME 			:= inception
DOCKER-COMPOSE 	:= ./srcs/docker-compose.yml
ENV_FILE 		:= ./srcs/.env
VOLUMES_DIR 	:= /home/jmouaike42/data

all: build

build: setup
	echo $(OR) "⣿⣿⣿ Inception ⣿⣿⣿" $(RES)
	docker compose -f $(DOCKER-COMPOSE) --env-file $(ENV_FILE) up -d --build

start:
	docker compose -f $(DOCKER-COMPOSE) start

stop:
	docker compose -f $(DOCKER-COMPOSE) stop

down:
	docker compose -f $(DOCKER-COMPOSE) down 

ps:
	docker ps

clean: stop
	docker compose -f $(DOCKER-COMPOSE) down

fclean: clean
	docker rmi -f $$(docker images -qa)
	docker volume rm $$(docker volume ls ) 2>/dev/null
	docker network rm $$(docker network ls) 2>/dev/null

prune: down
	echo $(PK) "⣿⣿⣿ make prune ⣿⣿⣿" $(RES)
	docker image prune -a
	sudo rm -rf $(VOLUMES_DIR)
	docker compose -f $(DOCKER-COMPOSE) down --remove-orphans
	docker compose -f $(DOCKER-COMPOSE) down --volumes
	sudo sed -i '1s/jmouaike.42.fr www.jmouaike.42.fr/localhost/' '/etc/hosts'

re: fclean all
	

images:
	docker images -qa

network:
	docker network ls

volume:
	docker volume ls

logs:
	docker logs -t -f $$(docker compose -f $(DOCKER-COMPOSE) ps -q nginx)

setup:
	mkdir -p $(VOLUMES_DIR)/website
	mkdir -p $(VOLUMES_DIR)/database
	$(bash ./srcs/requirements/tools/setup.sh)

help:
	echo $(OR)Inception $(PK)help$(RES)

.PHONY: all build start stop down ps clean fclean \
		re images network volume logs setup help

#### ANSI escape codes ###
OR = "\33[1;38:5:214m"
PK = "\33[1;95:185:55m"
RES = "\33[0m"