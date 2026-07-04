FROM debian:bullseye

RUN apt update && apt install -y \
    php-fpm \
    php-mysql \
    curl \
    mariadb-client \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY script.sh /usr/local/bin/script.sh

RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT ["/usr/local/bin/script.sh"]