FROM debian:bullseye

RUN apt update && \
    apt install -y vsftpd

COPY vsftpd.conf /etc/vsftpd.conf

COPY script.sh .

RUN chmod +x script.sh

ENTRYPOINT ["./script.sh"]