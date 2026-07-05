#!/bin/bash

set -e

WP_PATH="/var/www/html"
chown -R www-data:www-data "$WP_PATH"

echo "Waiting for MariaDB..."

until mysqladmin \
    --host="$WORDPRESS_DB_HOST" \
    --user="$MYSQL_USER" \
    --password="$MYSQL_PASSWORD" \
    ping --silent
do
    echo "MariaDB is not ready yet..."
    sleep 1
done

echo "MariaDB is ready!"


if [ ! -f "$WP_PATH/wp-load.php" ]; then
    su -s /bin/bash www-data -c \
    "wp core download --path='$WP_PATH'"
fi



if [ ! -f "$WP_PATH/wp-config.php" ]; then
    su -s /bin/bash www-data -c \
    "wp config create \
        --path='$WP_PATH' \
        --dbname='$MYSQL_DATABASE' \
        --dbuser='$MYSQL_USER' \
        --dbpass='$MYSQL_PASSWORD' \
        --dbhost='$WORDPRESS_DB_HOST' \
        --skip-check"
fi



if ! su -s /bin/bash www-data -c \
    "wp core is-installed --path='$WP_PATH'"; then

    su -s /bin/bash www-data -c "
        wp core install \
            --path='$WP_PATH' \
            --url='$DOMAIN_NAME' \
            --title='$WP_TITLE' \
            --admin_user='$WP_ADMIN' \
            --admin_password='$WP_ADMIN_PASSWORD' \
            --admin_email='$WP_ADMIN_EMAIL' \
            --skip-email

        wp user create \
            '$WP_USER' \
            '$WP_USER_EMAIL' \
            --user_pass='$WP_USER_PASSWORD'
    "
fi

echo "Starting PHP-FPM..."

exec php-fpm -F