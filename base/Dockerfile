FROM debian:stretch-slim
LABEL maintainer="mail@edwinhoksberg.nl"

ENV TERM=xterm DEBIAN_FRONTEND=noninteractive

# Copy scripts to image
COPY rootfs /

# Make apt/dpkg faster: https://unix.stackexchange.com/a/7242
RUN echo force-unsafe-io >> /etc/dpkg/dpkg.cfg && \
    # Silence apt warnings: https://github.com/phusion/baseimage-docker/issues/58#issuecomment-47995343
    echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Update/upgrade debian and install additional packages
RUN apt-get update && \
    apt-get-safeinstall software-properties-common apt-transport-https wget gnupg2 dirmngr && \
    apt-get upgrade -y && \
    apt-get-clean
