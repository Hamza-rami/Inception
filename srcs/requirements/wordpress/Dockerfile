FROM debian:bullseye

RUN apt update && \
    apt install -y \
        php-fpm \
        php-mysql \
        mariadb-client \
        curl

RUN mkdir -p /run/php

RUN sed -i 's|^listen = .*|listen = 9000|' \
    /etc/php/7.4/fpm/pool.d/www.conf

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar &&\
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY script.sh /usr/local/bin/script.sh


RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT ["/usr/local/bin/script.sh"]