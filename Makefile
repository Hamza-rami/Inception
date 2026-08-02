LOGIN := $(shell whoami)
DATA_PATH := /home/$(LOGIN)/data

COMPOSE = docker compose -f srcs/docker-compose.yml

all: up

up:
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress
	$(COMPOSE) up --build -d

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v

fclean: clean
	$(COMPOSE) down --rmi all -v
	@sudo rm -rf $(DATA_PATH)/mariadb
	@sudo rm -rf $(DATA_PATH)/wordpress

re: fclean up

.PHONY: all up down clean fclean re