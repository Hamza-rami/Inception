FROM debian:bullseye

RUN apt update && apt install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    wget

RUN mkdir -p /var/www/html/adminer

RUN wget -O /var/www/html/adminer/index.php \
    https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php

RUN sed -i 's|^listen = .*|listen = 9000|' \
    /etc/php/7.4/fpm/pool.d/www.conf

RUN chown -R www-data:www-data /var/www/html

RUN mkdir -p /run/php

CMD ["php-fpm7.4", "-F"]