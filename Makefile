config-home:
	docker-compose -f docker-compose-home.yml config

build-home:
	docker-compose -f docker-compose-home.yml build

up-home: export DATA_DIR=/Users/carltonjoseph/cj/cj2020/websites
up-home:
	docker-compose -f docker-compose-home.yml up

bup-home: build-home up-home

down-home: export DATA_DIR=/Users/carltonjoseph/cj/cj2020/websites
down-home:
	docker-compose -f docker-compose-home.yml down

config-do: export DATA_DIR=/mnt/volume_sfo2_02/cj
config-do: 
	docker-compose -f docker-compose-do.yml config

build-do:
	docker-compose -f docker-compose-do.yml build

up-do: export DATA_DIR=/mnt/volume_sfo2_02/cj
up-do:
	docker-compose -f docker-compose-do.yml up

bup-do: build-do up-do

down-do: export DATA_DIR=/mnt/volume_sfo2_02/cj
down-do:
	docker-compose -f docker-compose-do.yml down

build-home-apps:
	docker-compose -f docker-compose-home.yml build apps4tracking

up-home-apps:
	docker-compose -f docker-compose-home.yml up apps4tracking

bup-home-apps: build-home-apps up-home-apps

down-home-apps:
	docker-compose down apps4tracking

restart-do-apps:
	docker restart docker_appsfortracking_1

.PHONY: cert-sophieandchampagne.com
cert-sophieandchampagne:
	certbot certonly --standalone --config-dir ./cert --work-dir ./cert --logs-dir ./cert -d sophieandchampagne.com

.PHONY: cert-carltonwin8
cert-carlotnwin8:
	certbot certonly --standalone --config-dir ./cert --work-dir ./cert --logs-dir ./cert -d carltonwin8.com

.PHONY: cert-carltonathome
cert-carltonathome:
	certbot certonly --standalone --config-dir ./cert --work-dir ./cert --logs-dir ./cert -d carltonathome.com

.PHONY: cert-tinaandcarlton
cert-tinaandcarlton:
	certbot certonly --standalone --config-dir ./cert --work-dir ./cert --logs-dir ./cert -d tinaandcarlton.com

.PHONY: cert-appsfortracking
cert-appsfortracking:
	certbot certonly --standalone --config-dir ./cert --work-dir ./cert --logs-dir ./cert -d appsfortracking.com

.PHONY: cert-apps4tracking
cert-apps4tracking:
	certbot certonly --standalone --config-dir ./cert --work-dir ./cert --logs-dir ./cert -d apps4tracking.com

.PHONY: cert-carltonjoseph
cert-carltonjoseph:
	certbot certonly --standalone --config-dir ./cert --work-dir ./cert --logs-dir ./cert -d carltonjoseph.com

.PHONY: cert-renew
cert-renew:
	certbot renew --standalone --config-dir ./cert --work-dir ./cert --logs-dir ./cert
