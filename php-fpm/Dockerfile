FROM edwinhoksberg/base
MAINTAINER Edwin Hoksberg <mail@edwinhoksberg.nl>

RUN export DEBIAN_FRONTEND=noninteractive

# Install new php package repository and package signing key
RUN echo "deb https://packages.sury.org/php jessie main" > /etc/apt/sources.list.d/php.list
RUN wget -qO - "https://packages.sury.org/php/apt.gpg" | apt-key add -

# Update apt repositories
RUN apt-get update

# Install php + extensions
ADD install-php.sh install-php.sh
RUN chmod +x install-php.sh && ./install-php.sh && rm install-php.sh

# Clean apt caches
RUN apt-get-clean

# Copy config files over
COPY rootfs /

# Create php-fpm pid directory
RUN mkdir -p /run/php

# Copy startup script
COPY start-services.sh start-services.sh
RUN chmod +x start-services.sh

# Start php-fpm and tail logs
CMD [ "./start-services.sh" ]
