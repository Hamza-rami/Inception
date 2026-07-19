#!/bin/bash

set -e

WP_PATH="/var/www/html"

until mysqladmin ping -h mariadb --silent; do
    sleep 1
done

if [ ! -f "$WP_PATH/wp-config.php" ]; then

    wp core download --path="$WP_PATH" --allow-root

    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost="mariadb" \
        --path="${WP_PATH}" \
        --allow-root
    
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --path="$WP_PATH" \
        --allow-root

    wp user create \
        "${WP_USER}" \
        "${WP_USER_EMAIL}" \
        --user_pass="${WP_USER_PASSWORD}" \
        --role=author \
        --path="$WP_PATH" \
        --allow-root

fi

exec php-fpm -F