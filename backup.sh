

## backup postgres volume into tar
docker run --rm --volumes-from postgres -v $(pwd):/backup alpine tar -cvf /backup/bak_v_postgres11.tar -C /var/lib/postgresql data

## restore
docker run --rm -v v_postgres11:/var/lib/postgresql/data -v $(pwd):/backup alpine tar -xvf /backup/bak_v_postgres11.tar -C /var/lib/postgresql



docker run --rm -it -v v_postgres11:/var/lib/postgresql/11/data -v v_postgres12:/var/lib/postgresql/12/data --name pgu postgres:12 #!/usr/bin/env bash

## exec
apt-get update && apt-get install postgresql-11
chown -R postgres:postgres /var/lib/postgresql

chown -R postgres:postgres /var/lib/postgresql

su postgres
initdb -D /var/lib/postgresql/12/data

cd /var/lib/postgresql

pg_upgrade -b /usr/lib/postgresql/11/bin -B /usr/lib/postgresql/12/bin -d /var/lib/postgresql/11/data -D /var/lib/postgresql/12/data -v
