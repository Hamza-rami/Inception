FROM debian:bullseye

RUN apt update && \
    apt install -y vsftpd

COPY ./conf/vsftpd.conf /etc/vsftpd.conf

COPY ./tools/script.sh .

RUN chmod +x script.sh

ENTRYPOINT ["./script.sh"]