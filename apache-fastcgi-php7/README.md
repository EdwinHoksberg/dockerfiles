# How to use

Build docker image:
`docker build -t apache-fastcgi-php7 .`

Run the container:
`docker run -p 80 -v /var/www/html:/var/www/html --name webdev -d apache-fastcgi-php7:latest`

If you use mysql, you can mount the socket like this:
`docker run -p 80 -v /var/www/html:/var/www/html -v /var/run/mysqld/mysqld.sock:/var/run/mysqld/mysqld.sock --name webdev -d apache-fastcgi-php7:latest`
