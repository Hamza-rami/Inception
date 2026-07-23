FROM debian:bullseye

RUN apt update && \
    apt install -y vsftpd

COPY script.sh /script.sh

RUN chmod +x /script.sh

ENTRYPOINT ["/script.sh"]