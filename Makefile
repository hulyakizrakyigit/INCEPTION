DC := docker-compose -f ./srcs/docker-compose.yml

all:
	@mkdir -p /home/hkizrak-/data/wordpress
	@mkdir -p /home/hkizrak-/data/mysql
	@$(DC) up -d --build

down:
	@$(DC) down

re: clean all

clean:
	@$(DC) down -v --remove-orphans   
	@docker rmi -f $$(docker images -q)
.PHONY: all down re clean
