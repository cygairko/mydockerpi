# mydockerpi
Raspberry Pi homeserver running Nextcloud in a Docker environment. Nextcloud is available on the given domain name. Further services are using subdomains.

## Todo
- Backup volumes

## Step by step
### Preparation
Clone this repository.
```
git clone git@github.com:cygairko/mydockerpi.git
cd mydockerpi
```
```
touch ~/mydockerpi/basesvc/traefik/acme.json
chmod 600 ~/mydockerpi/basesvc/traefik/acme.json
```

Create ```.env``` file
```
vim ~/mydockerpi/.env
```

with this content and adjust the settings.
```
DOMAINNAME=mycloud.example.com

ACME_EMAIL=mail@mycloud.example.com

NEXTCLOUD_ADMIN_USER=someadmin
NEXTCLOUD_ADMIN_PASSWORD=MySuperSecretNextcloudPassword

POSTGRES_PASSWORD=MySuperSecretDbPassword
```

### Create docker volumes
They will be our storages and can be archived for backup reasons later on.
```
docker volumes create v_portainer
docker volumes create v_nextcloud
docker volumes create v_postgres
docker volumes create v_redis
```

### Get the containers running
First download the images. Currently I am testing on a Pi 2 Model B but should work on other models as well.
```
docker-compose -f docker-compose-basesvc.yml pull
```

```
docker-compose -f docker-compose-basesvc.yml up -d
```
It'll take a while until containers are completely up. Traefik will grab the certificates one after another. When you can access traefik.mycloud.example.com (and the other services) without a cert warning everything's up.

## Benefits
- Watchtower will keep the containers updated.
- Traefik will automatically take care about SSL certs from Let's encrypt.
- Only manual changes required in .env file.
- Images are mainly based on alpine to keep a small footprint.
