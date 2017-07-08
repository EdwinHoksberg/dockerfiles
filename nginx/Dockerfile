FROM edwinhoksberg/base
MAINTAINER Edwin Hoksberg <mail@edwinhoksberg.nl>

# Install nginx
RUN apt-get-safeinstall nginx

# Copy nginx sites config
COPY sites.conf /etc/nginx/sites-enabled/

# Clean apt caches
RUN apt-get-clean

# Run nginx in foreground mode
CMD [ "nginx", "-g", "daemon off;" ]
