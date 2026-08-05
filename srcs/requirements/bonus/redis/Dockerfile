FROM debian:bookworm

RUN apt update && \
    apt install -y redis-server

COPY ./conf/redis.conf /etc/redis/redis.conf

CMD ["redis-server", "/etc/redis/redis.conf"]