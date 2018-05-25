#!/bin/bash

mysql="/usr/local/mariadb/columnstore/mysql/bin/mysql --defaults-file=/usr/local/mariadb/columnstore/mysql/my.cnf -uroot -e"
flag=/initialized

function columnstore_shutdown {
    /usr/local/mariadb/columnstore/bin/mcsadmin shutdownSystem y
}

function columnstore_startup {
    # Starting process manager
    /usr/local/mariadb/columnstore/bin/ProcMon &

    # Start columnstore
    /usr/local/mariadb/columnstore/bin/mcsadmin startSystem
}

echo "[Docker] Starting columnstore..."
columnstore_startup

# Initial database setup
if [ ! -f $flag ]; then
    # Generate a random password for the root user
    if [ "$MYSQL_RANDOM_ROOT_PASSWORD" = "yes" ]; then
        MYSQL_ROOT_PASSWORD=$(pwgen 20 1)

        echo "[Docker] Generated password for root user: ${MYSQL_ROOT_PASSWORD}"
    fi

    # Set the root password, if one was provided
    if [ "$MYSQL_ROOT_PASSWORD" != "" ]; then
        $mysql "ALTER USER root@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';FLUSH PRIVILEGES;"
    fi

    touch $flag
fi

# Trap signals for detecting shutdown
trap columnstore_shutdown INT TERM

echo "[Docker] Started columnstore, waiting for SIGINT/SIGTERM..."

# Start a infinitly waiting process and wait for it to shutdown
sleep infinity &
pid=$!

wait "$pid"
