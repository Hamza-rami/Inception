#!/bin/bash

set -e

DATADIR="/var/lib/mysql"
SOCKET="/run/mysqld/mysqld.sock"

echo "========== MariaDB Startup =========="

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld
chown -R mysql:mysql "$DATADIR"

echo "Starting temporary MariaDB..."

su -s /bin/bash mysql -c \
"mariadbd --datadir=$DATADIR --socket=$SOCKET --skip-networking" &

MYSQL_PID=$!

echo "Waiting for temporary MariaDB..."

until mysqladmin --socket="$SOCKET" ping --silent
do
    sleep 1
done

echo "Temporary MariaDB is ready."

if ! mariadb --socket="$SOCKET" \
    -e "SHOW DATABASES LIKE '${MYSQL_DATABASE}';" \
    | grep -q "${MYSQL_DATABASE}"
then
    echo "========== First initialization =========="

    mariadb --socket="$SOCKET" \
        -e "CREATE DATABASE ${MYSQL_DATABASE};"

    mariadb --socket="$SOCKET" \
        -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

    mariadb --socket="$SOCKET" \
        -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"

    mariadb --socket="$SOCKET" \
        -e "FLUSH PRIVILEGES;"

    echo "Database initialized."
else
    echo "Database already initialized."
fi

echo "Stopping temporary MariaDB..."

mariadb --socket="$SOCKET" -e "SHUTDOWN;"

wait "$MYSQL_PID"

echo "Starting production MariaDB..."

exec su -s /bin/bash mysql -c \
"exec mariadbd --datadir=$DATADIR --socket=$SOCKET"