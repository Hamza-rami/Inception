FROM debian:bullseye

ARG DOMAIN_NAME

RUN apt update && apt install -y \
    nginx \
    openssl \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

RUN openssl req \
    -x509 \
    -newkey rsa:4096 \
    -nodes \
    -days 365 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=MA/ST=Beni Mellal/L=Kouribga/O=42/OU=1337/CN=${DOMAIN_NAME}"

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]