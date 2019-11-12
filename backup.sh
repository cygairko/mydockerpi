

## backup postgres volume into tar
docker run --rm --volumes-from postgres -v $(pwd):/backup alpine tar cvf /backup/bak_v_postgres11.tar /var/lib/postgresql/data

## restore
docker run -v v_postgres11:/var/lib/postgresql/data -v $(pwd):/backup alpine tar xvf /backup/bak_v_postgres11.tar -C /var/lib/postgresql/data --strip 1
