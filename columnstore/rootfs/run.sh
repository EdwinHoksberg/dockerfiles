#!/bin/sh

mysql="/usr/local/mariadb/columnstore/mysql/bin/mysql --defaults-file=/usr/local/mariadb/columnstore/mysql/my.cnf -uroot -e"
flag=/initialized

trap "/usr/local/mariadb/columnstore/bin/mcsadmin shutdownSystem y" INT TERM

echo "Starting columnstore..."
/usr/local/mariadb/columnstore/bin/mcsadmin startSystem

if [ ! -f $flag ]; then
    # Generate a random password for the root user
    if [ "$MYSQL_RANDOM_ROOT_PASSWORD" = "yes" ]; then
        MYSQL_ROOT_PASSWORD=$(pwgen 20 1)

        echo "Generated password for root user: ${MYSQL_ROOT_PASSWORD}"
    fi

    # Set the root password, if one was provided
    if [ "$MYSQL_ROOT_PASSWORD" != "" ]; then
        $mysql "ALTER USER root@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';FLUSH PRIVILEGES;"
    fi

    touch $flag
fi

echo "Started columnstore, waiting for SIGINT/SIGTERM..."
sleep infinity &
pid=$!

wait "$pid"
