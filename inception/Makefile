NAME 			:= inception
DOCKER-COMPOSE 	:= ./srcs/docker-compose.yml
ENV_FILE 		:= ./srcs/.env
VOLUMES_DIR 	:= /home/jmouaike42/data

all: build

build: setup
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
	docker rmi -f $$(docker images -qa) > /dev/null 2>&1
	docker volume rm $$(docker volume ls | grep ) > /dev/null 2>&1
	docker network rm $$(docker network ls) > /dev/null 2>&1

prune: down
	docker image prune -a
	sudo rm -rf $(VOLUMES_DIR)
	docker compose -f $(DOCKER-COMPOSE) down --remove-orphans
	docker compose -f $(DOCKER-COMPOSE) down --volumes

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
	$(bash ./srcs/requirements//tools/setup.sh)


.PHONY: all setup build start stop down ps clean fclean re images network volume logs