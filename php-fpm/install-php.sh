#!/bin/bash

PHPVERSIONS=("5.6" "7.0" "7.1")

for version in "${PHPVERSIONS[@]}"; do
    apt-get-safeinstall \
        php"$version"-fpm \
        php"$version"-mysql \
        php"$version"-pdo \
        php"$version"-curl \
        php"$version"-gd \
        php"$version"-imagick \
        php"$version"-mbstring \
        php"$version"-mcrypt \
        php"$version"-memcached \
        php"$version"-xmlrpc \
        php"$version"-xsl \
        php"$version"-xdebug \
        php"$version"-imap \
        php"$version"-mongo \
        php"$version"-iconv
done
