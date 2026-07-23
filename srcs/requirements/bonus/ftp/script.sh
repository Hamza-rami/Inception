#!/bin/bash

set -e

FTP_CONF="/etc/vsftpd.conf"

useradd -m \
    -d /var/www/html \
    -s /bin/bash \
    "$FTP_USER"
echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd


sed -i 's/^listen=.*/listen=YES/' /etc/vsftpd.conf
sed -i 's/^listen_ipv6=.*/listen_ipv6=NO/' /etc/vsftpd.conf
echo "chroot_local_user=YES" >> /etc/vsftpd.conf
echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf
echo "pasv_enable=YES" >> /etc/vsftpd.conf
echo "pasv_min_port=30000" >> /etc/vsftpd.conf
echo "pasv_max_port=30009" >> /etc/vsftpd.conf