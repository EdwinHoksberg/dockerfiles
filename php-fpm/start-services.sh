#!/bin/sh

php-fpm5.6 &
php-fpm7.0 &
php-fpm7.1

tail -f /var/log/php5.6-fpm.log /var/log/php7.0-fpm.log /var/log/php7.1-fpm.log
