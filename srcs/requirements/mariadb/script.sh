#!/bin/bash

set -e

DATADIR="/var/lib/mysql"
SOCKET="/run/mysqld/mysqld.sock"

if [ ! -d "$DATADIR/mysql" ]; then
    echo "Initializing MariaDB..."

    chown -R mysql:mysql "$DATADIR"

    mariadb-install-db --user=mysql --datadir="$DATADIR"

    su -s /bin/bash mysql -c "mariadbd --datadir=$DATADIR --socket=$SOCKET --skip-networking" &

    until mysqladmin --socket="$SOCKET" ping --silent
    do
        sleep 1
    done

    mariadb --socket="$SOCKET" -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    mariadb --socket="$SOCKET" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mariadb --socket="$SOCKET" -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    mariadb --socket="$SOCKET" -e "FLUSH PRIVILEGES;"
    mariadb --socket="$SOCKET" -e "SHUTDOWN;"

fi

exec su -s /bin/bash mysql -c "exec mariadbd --datadir=$DATADIR --socket=$SOCKET"