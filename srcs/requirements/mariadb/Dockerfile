FROM debian:bullseye

RUN apt update && \
    apt install -y mariadb-server && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' \
/etc/mysql/mariadb.conf.d/50-server.cnf

COPY script.sh /usr/local/bin/script.sh

RUN chmod +x /usr/local/bin/script.sh

CMD ["/usr/local/bin/script.sh"]