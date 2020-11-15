# mydockerpi
Raspberry Pi homeserver running Nextcloud and some other services around in a Docker environment. Nextcloud is available on the given domain name. Further services are using subdomains.
Precondition is to have a dyndns domain - we consider this to be updated by the router. A container hosting ddclient can be used though.

## Todo
- Backup volumes
- Use docker secrets for the passwords
- Migrate to traefik v2
- Migrate to docker stack instead docker-compose

## Benefits
- Traefik will automatically take care about SSL certs from Let's encrypt.
- Only manual changes required in .env file.
- Images are mainly based on alpine to keep a small footprint.

## Installation
### Preparation
Clone this repository.
```
git clone git@github.com:cygairko/mydockerpi.git
cd mydockerpi
```

### Starting the backend
```
mkdir ~/mydockerpi/backend/acme
touch ~/mydockerpi/backend/acme/acme.json
chmod 600 ~/mydockerpi/traefik/acme.json
```

Create ```.env``` from sample file
```
cp ~/mydockerpi/backend/sample.env ~/mydockerpi/backend/.env
```
and update with your used domain and acme_email (for Let's Encrypt).

#### Create volumes and networks
They will be our storages and can be archived for backup reasons later on.
```
docker volume create v_portainer
docker network create n_traefik_proxy
```

#### Get it running
Currently I am testing on a Pi 2 Model B but should work on other models like 3 and 4 as well. I have chosen to use two separate compose files. Some basic services won't be stopped when ```down```ing nextcloud parts. whoami container is more for debug reasons. So let's get the backend services up now:
```
cd ~/mydockerpi/backend
docker-compose pull
docker-compose up -d
```

### Home Assistant
Define variable for domain:
```
cp ~/mydockerpi/ha/sample.env ~/mydockerpi/ha/.env
```
```
docker volume create v_homeassistant
```
```
cd ~/mydockerpi/ha
docker-compose pull
docker-compose up -d
```

### Nextcloud

Define some variables for passwords etc:
```
cp ~/mydockerpi/nextcloud/sample.env ~/mydockerpi/nextcloud/.env
```
```
docker volume create v_nextcloud
docker volume create v_postgres
docker volume create v_redis
```
```
cd ~/mydockerpi/nextcloud
docker-compose pull
docker-compose up -d
```

It'll take a while until containers are completely up. Traefik will grab the certificates one after another. When you can access traefik.mycloud.example.com (and the other services) without a cert warning everything's up. Also nextcloud (2nd compose file) setup almost took 15min on my Pi2. Watch ```docker logs nextcloud -f``` accordingly.
