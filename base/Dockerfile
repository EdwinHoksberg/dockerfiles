FROM debian:jessie-slim
MAINTAINER Edwin Hoksberg <mail@edwinhoksberg.nl>

RUN export DEBIAN_FRONTEND=noninteractive
RUN export TERM=xterm

# Copy scripts to image
COPY rootfs /

# Make apt/dpkg faster: https://unix.stackexchange.com/a/7242
RUN echo force-unsafe-io >> /etc/dpkg/dpkg.cfg

# Update apt repositories
RUN apt-get update

# Install additional packages
RUN apt-get-safeinstall software-properties-common \
    apt-transport-https wget gnupg2 dirmngr

# Upgrade all packages
RUN apt-get upgrade -y

# Setup language
RUN export LANG=en_US.UTF-8
RUN export LC_ALL=en_US.UTF-8
RUN apt-get-safeinstall locales && locale-gen en_US.UTF-8
