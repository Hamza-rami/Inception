FROM debian:bullseye

RUN apt update && \
    apt instal -y nginx apenssl



RUN openssl req \
    -x509 \
    -nodes \
    -days 365 \
    -newkey rsa:4096 \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt \
    -subj "/C=MA/ST=beni Mellal/L=khouribga/O=42/OU=1337/CN=hrami.42.fr"
    
EXPOSE 443

COPY nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]