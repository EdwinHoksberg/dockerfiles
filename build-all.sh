#!/bin/sh

# Show all commands being executed and stop executing if an error occurs.
set -ex

docker build --pull -t edwinhoksberg/base base

docker build -t edwinhoksberg/data-volume data-volume

docker build -t edwinhoksberg/nginx nginx

docker build -t edwinhoksberg/php-fpm php-fpm

echo "All done!"
