build-home:
	docker-compose -f docker-compose-home.yml build

up-home:
	docker-compose -f docker-compose-home.yml up

bup-home: build-home up-home

build-do:
	docker-compose -f docker-compose-do.yml build

up-do:
	docker-compose -f docker-compose-do.yml up

bup-do: build-do up-do
