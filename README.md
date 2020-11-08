# mydockerpi
Raspberry Pi homeserver running Nextcloud and some other services around in a Docker environment. Nextcloud is available on the given domain name. Further services are using subdomains.

## Todo
- Backup volumes
- Use docker secrets for the passwords
- Migrate to traefik v2
- Migrate to docker stack instead docker-compose

## Step by step
### Preparation
Clone this repository.
```
git clone git@github.com:cygairko/mydockerpi.git
cd mydockerpi
```
```
touch ~/mydockerpi/traefik/acme.json
chmod 600 ~/mydockerpi/traefik/acme.json
```

Create ```.env``` from sample file
```
cp ~/mydockerpi/sample.env ~/mydockerpi/.env
```
and update content with your domain and passwords.

### Create docker volumes and networks
They will be our storages and can be archived for backup reasons later on.
```
docker volume create v_portainer
docker volume create v_nextcloud
docker volume create v_postgres
docker volume create v_redis

docker network create n_traefik_proxy
```

### Get the containers running
First download the images. Currently I am testing on a Pi 2 Model B but should work on other models as well. I have chosen to use two separate compose files. Some basic services won't be stopped when ```down```ing nextcloud parts. whoami container is more for debug reasons.
```
docker-compose -f docker-compose-basesvc.yml pull
docker-compose -f docker-compose-nextcloud.yml pull
```

```
docker-compose -f docker-compose-basesvc.yml up -d
docker-compose -f docker-compose-nextcloud.yml up -d
```
It'll take a while until containers are completely up. Traefik will grab the certificates one after another. When you can access traefik.mycloud.example.com (and the other services) without a cert warning everything's up. Also nextcloud (2nd compose file) setup almost took 15min on my Pi2. Watch ```docker logs nextcloud -f``` accordingly.

## Benefits
- Watchtower will keep the containers updated.
- Traefik will automatically take care about SSL certs from Let's encrypt.
- Only manual changes required in .env file.
- Images are mainly based on alpine to keep a small footprint.
