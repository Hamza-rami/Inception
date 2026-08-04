FROM debian:bookworm

RUN apt update && \
    apt install -y nginx

COPY website/ /var/www/html/static

COPY ./conf/default.conf /etc/nginx/sites-available/default

CMD ["nginx", "-g", "daemon off;"]