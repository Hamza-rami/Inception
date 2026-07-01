FROM debian:stable

RUN apt update && \
    apt install -y mariadb-server && \
    apt clean

COPY script.sh /usr/local/bin/script.sh

RUN chmod +x /usr/local/bin/script.sh

CMD ["/usr/local/bin/script.sh"]