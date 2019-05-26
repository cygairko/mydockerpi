# mydockerpi
Raspberry Pi homeserver running Nextcloud in a Docker environment

## Todo
- Backup volumes

## Step by step
Clone this repository.
```
git clone git@github.com:cygairko/mydockerpi.git
cd mydockerpi
```
```
chmod 600 ~/mydockerpi/basesvc/traefik/acme.json
```

Create ```.env``` file
```
vim ~/mydockerpi/basesvc/.env
```

with this content and adjust settings to your values.
```
DOMAINNAME=mycloud.example.com
BASESVCDIR=/home/username/mydockerpi/basesvc

ACME_EMAIL=mail@mycloud.example.com
```
