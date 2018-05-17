#!/bin/sh

set -e

mcsadmin="/usr/local/mariadb/columnstore/bin/mcsadmin"
mysql="/usr/local/mariadb/columnstore/mysql/bin/mysql --defaults-file=/usr/local/mariadb/columnstore/mysql/my.cnf -uroot -vvv -Be"

# Fix environment
mkdir -p /var/log/mariadb/columnstore && \
    /bin/echo "export USER=root" >> /root/.bashrc
    /bin/cat /usr/local/mariadb/columnstore/bin/columnstoreAlias >> /root/.bashrc

# Update root user to allow external connections
$mysql "set sql_mode=NO_ENGINE_SUBSTITUTION;GRANT ALL ON *.* to root@'%';FLUSH PRIVILEGES;"

# Shutdown server so everything is in a clean state for running
$mcsadmin shutdownsystem y

# Clear any alarms
/usr/local/mariadb/columnstore/bin/mcsadmin resetAlarm ALL
