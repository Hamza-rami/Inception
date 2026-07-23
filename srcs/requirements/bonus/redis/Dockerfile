FROM debian:bullseye

RUN apt update && \
    apt install -y redis-server

CMD ["redis-server", "--bind", "0.0.0.0", "--daemonize", "no"]