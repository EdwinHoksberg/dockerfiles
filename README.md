# Dockerfiles

A repository of my docker containers.

## base
A base container from which all other containers extend.

## data-volume
An empty container, used for mounting volumes across containers.
```
docker run --volume /directory-to-mount:/var/www/html --name data-volume edwinhoksberg/data-volume
```

## nginx
A container running nginx, with the ability to accept a custom `sites.conf`.
```
docker run --volumes-from=data-volume --link php-fpm --name nginx edwinhoksberg/nginx
```

## php-fpm
A container with php 7.0 installed, can be linked to the nginx container with php-fpm.
```
docker run --volumes-from=data-volume --hostname php-fpm --name php-fpm edwinhoksberg/php-fpm
```
