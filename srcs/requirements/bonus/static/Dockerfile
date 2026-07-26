FROM debian:bullseye

RUN apt update && \
    apt install -y nginx

COPY website/ /var/www/html/static

COPY default.conf /etc/nginx/sites-available/default

CMD ["nginx", "-g", "daemon off;"]