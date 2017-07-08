FROM edwinhoksberg/base
MAINTAINER Edwin Hoksberg <mail@edwinhoksberg.nl>

RUN export DEBIAN_FRONTEND=noninteractive

# Install php + extensions
RUN apt-get-safeinstall php7.0-fpm php7.0-mysql php7.0-pdo \
    php7.0-curl php7.0-gd php7.0-imagick php7.0-mbstring \
    php7.0-mcrypt php7.0-memcached php7.0-pspell php7.0-recode \
    php7.0-tidy php7.0-xmlrpc php7.0-xsl php7.0-xdebug php7.0-imap

# Clean apt caches
RUN apt-get-clean

# Create php-fpm pid directory
RUN mkdir -p /run/php

# Overwrite the default fpm pool with ours
COPY pool.conf /etc/php/7.0/fpm/pool.d/www.conf

# Force run php-fpm in foreground
CMD [ "/usr/sbin/php-fpm7.0", "-F", "-O" ]
