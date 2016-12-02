FROM debian:latest
MAINTAINER Edwin Hoksberg <mail@edwinhoksberg.nl>

RUN export DEBIAN_FRONTEND=noninteractive

# Add non-free and dotdeb packages 
RUN echo 'deb http://ftp.nl.debian.org/debian stable main contrib non-free\n\
deb-src http://ftp.nl.debian.org/debian stable main contrib non-free\n\
deb http://ftp.debian.org/debian/ wheezy-updates main contrib non-free\n\
deb-src http://ftp.debian.org/debian/ wheezy-updates main contrib non-free\n\
deb http://security.debian.org/ wheezy/updates main contrib non-free\n\
deb-src http://security.debian.org/ wheezy/updates main contrib non-free\n\
deb http://packages.dotdeb.org jessie all\n\
deb-src http://packages.dotdeb.org jessie all'\ > /etc/apt/sources.list

# Update installation + apache and install dependencies
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E9C74FEEA2098A6E \
    && apt-get update \
    && apt-get install -y apache2 libapache2-mod-fastcgi supervisor php7.0 php7.0-dev php7.0-mysql php7.0-bcmath php7.0-bz2 php7.0-dba php7.0-gd php7.0-intl php7.0-mcrypt php7.0-pspell php7.0-soap php7.0-sqlite3 php7.0-zip php7.0-xml php7.0-xdebug php7.0-fpm php7.0-curl php7.0-mbstring \
    && rm -rf /var/lib/apt/lists/* \
;

# Create fcgi socket
RUN touch /usr/lib/cgi-bin/php7.fcgi \
    && chown www-data:www-data /usr/lib/cgi-bin/php7.fcgi

# Create apache module for php fastcgi
RUN echo '<IfModule mod_fastcgi.c>\n\
    AddHandler php7.fcgi .php\n\
    Action php7.fcgi /php7.fcgi\n\
    Alias /php7.fcgi /usr/lib/cgi-bin/php7.0.fcgi\n\
    FastCgiExternalServer /usr/lib/cgi-bin/php7.0.fcgi -socket /var/run/php/php7.0-fpm.sock -pass-header Authorization -idle-timeout 360\n\
    <Directory /usr/lib/cgi-bin>\n\
        Require all granted\n\
    </Directory>\n\
</IfModule>\n\
'\ > /etc/apache2/conf-available/php7-fpm.conf

# Copy vhost and enable apache modules
COPY vhost.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod actions rewrite \
    && a2enconf php7-fpm \
;

# Expose port 80 to the outside
EXPOSE 80

# Copy our supervisord config file
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf" ]
