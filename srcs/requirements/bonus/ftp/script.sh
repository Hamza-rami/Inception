#!/bin/bash

set -e

FTP_CONF="/etc/vsftpd.conf"

# -----------------------------
# Create FTP user
# -----------------------------
useradd -M \
    -d /var/www/html \
    -s /bin/bash \
    "$FTP_USER"

echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd

# Allow FTP user to write to WordPress files
usermod -aG www-data "$FTP_USER"

# -----------------------------
# Configure vsftpd
# -----------------------------

# Enable local users
sed -i 's/^anonymous_enable=.*/anonymous_enable=NO/' "$FTP_CONF"
sed -i 's/^local_enable=.*/local_enable=YES/' "$FTP_CONF"

# Enable uploads
sed -i 's/^#write_enable=.*/write_enable=YES/' "$FTP_CONF"

# Listen on IPv4
sed -i 's/^listen=.*/listen=YES/' "$FTP_CONF"
sed -i 's/^listen_ipv6=.*/listen_ipv6=NO/' "$FTP_CONF"

# Append options only if they don't already exist
grep -q "^chroot_local_user=" "$FTP_CONF" \
    || echo "chroot_local_user=YES" >> "$FTP_CONF"

grep -q "^allow_writeable_chroot=" "$FTP_CONF" \
    || echo "allow_writeable_chroot=YES" >> "$FTP_CONF"

grep -q "^pasv_enable=" "$FTP_CONF" \
    || echo "pasv_enable=YES" >> "$FTP_CONF"

grep -q "^pasv_min_port=" "$FTP_CONF" \
    || echo "pasv_min_port=30000" >> "$FTP_CONF"

grep -q "^pasv_max_port=" "$FTP_CONF" \
    || echo "pasv_max_port=30009" >> "$FTP_CONF"

grep -q "^pasv_address=" "$FTP_CONF" \
    || echo "pasv_address=127.0.0.1" >> "$FTP_CONF"

# -----------------------------
# Required by vsftpd
# -----------------------------
mkdir -p /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd
chmod 555 /var/run/vsftpd/empty

# -----------------------------
# Start FTP server
# -----------------------------
exec /usr/sbin/vsftpd "$FTP_CONF"