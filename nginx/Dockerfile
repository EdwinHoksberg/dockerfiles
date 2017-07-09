FROM edwinhoksberg/base
MAINTAINER Edwin Hoksberg <mail@edwinhoksberg.nl>

# Install nginx
RUN apt-get-safeinstall nginx

# Copy nginx config
COPY rootfs /

# Clean apt caches
RUN apt-get-clean

# Run nginx in foreground mode
CMD [ "nginx", "-g", "daemon off;" ]
