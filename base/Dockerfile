FROM debian:stretch-slim
MAINTAINER Edwin Hoksberg <mail@edwinhoksberg.nl>

RUN export DEBIAN_FRONTEND=noninteractive
RUN export TERM=xterm

# Copy scripts to image
COPY root /

# Make apt/dpkg faster: https://unix.stackexchange.com/a/7242
RUN echo force-unsafe-io >> /etc/dpkg/dpkg.cfg

# Update apt repositories
RUN apt-get update

# Install package for apt-add-repository command
RUN apt-get-safeinstall software-properties-common

# Upgrade all packages
RUN apt-get upgrade -y

# Setup language
RUN echo "export LANG=en_US.UTF-8" >> /root/.bashrc && \
    echo "export LANGUAGE=en_US:en" >> /root/.bashrc && \
    apt-get-safeinstall locales
