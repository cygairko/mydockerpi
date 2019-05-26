# mydockerpi
Raspberry Pi homeserver running Nextcloud in a Docker environment

## Todo
- Backup volumes

## Step by step
Clone this repository.
```
git clone git@github.com:cygairko/mydockerpi.git
```
```
chmod 600 ~/mydockerpi/basesvc/traefik/acme.json
```

Create ```.env``` file for setting domain etc according to your needs.
```
vim ~/mydockerpi/basesvc/.env
```


```
DOMAINNAME=mycloud.example.com
BASESVCDIR=/home/username/docker/basesvc

ACME_EMAIL=mail@mycloud.example.com
```
