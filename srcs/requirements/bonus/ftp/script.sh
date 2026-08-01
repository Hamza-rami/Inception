#!/bin/bash

set -e

useradd -M \
    -d /var/www/html \
    -s /bin/bash \
    "$FTP_USER"

echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd

usermod -aG www-data "$FTP_USER"

mkdir -p /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd
chmod 555 /var/run/vsftpd/empty

exec /usr/sbin/vsftpd /etc/vsftpd.conf