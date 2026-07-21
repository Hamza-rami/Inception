FROM debian:bullseye

RUN apt update && apt install -y mariadb-server
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

RUN rm -rf /var/lib/mysql/*

COPY script.sh /usr/local/bin/script.sh

RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT [ "/usr/local/bin/script.sh" ]