PHP_BASH=certification_php
DB_BASH=certification_db
NODE_BASH=certification_node

build: # build the project
	docker compose -f docker-compose.yml up -d --build --remove-orphans

start: # start the project
	docker compose up -d

stop: # stop the project
	docker compose stop

php_bash: # run the php bash script
	docker exec -it ${PHP_BASH} bash

db_bash: # run the db bash script
	docker exec -it $(DB_BASH) bash

db_stop: # stop the db container
	docker stop $(DB_BASH)

kg: # set the key for the app
	docker exec -it $(PHP_BASH) php artisan key:generate

composer_install: # install the composer
	docker exec -it $(PHP_BASH) composer install

copy_env: # copy the .env file
	cp .env.example .env

migrate: # migrate the database
	docker exec -it $(PHP_BASH) php artisan migrate:refresh  --seed

wipe:
	docker exec -it $(PHP_BASH) php artisan db:wipe

cc:
	docker exec -it $(PHP_BASH) php artisan cache:clear
