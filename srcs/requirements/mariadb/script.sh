#!/bin/bash

set -e

DATADIR="/var/lib/mysql"
SOCKET="/run/mysqld/mysqld.sock"

if [ ! -d "$DATADIR/mysql" ]; then

    mariadb-install-db \
        --datadir="$DATADIR" \
        --user=mysql

    mariadbd \
        --user=mysql \
        --datadir="$DATADIR" \
        --socket="$SOCKET" \
        --skip-networking &

    until mysqladmin ping --socket="$SOCKET" --silent; do
        sleep 1
    done

    mysql --socket="$SOCKET" \
        -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    
    mysql --socket="$SOCKET" \
        -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    
    mysql --socket="$SOCKET" \
        -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
        
    mysql --socket="$SOCKET" \
        -e "FLUSH PRIVILEGES;"

    mysqladmin --socket="$SOCKET" shutdown

fi

exec mariadbd \
    --user=mysql \
    --datadir="$DATADIR" \
    --socket="$SOCKET" \
    --bind-address=0.0.0.0