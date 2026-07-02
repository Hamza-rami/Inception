FROM debian:stable


RUN apt update && apt install -y \
    php-fpm \
    php-mysql \
    curl \
    mariadb-client \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

COPY script.sh /usr/local/bin/script.sh

RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT ["/usr/local/bin/script.sh"]