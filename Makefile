.PHONY: up down destroy logs console

up:
	docker compose up -d --build 

down:
	docker compose down

destroy:
	docker compose down -v --rmi all --remove-orphans
	docker volume prune -f
	docker image prune -af
	docker network prune -f
	docker system prune -af --volumes

logs:
	docker compose logs -f

logs-%:
	docker compose logs -f $*

console:
	docker compose run --rm console
restart:
	docker compose down
	docker compose up -d --build