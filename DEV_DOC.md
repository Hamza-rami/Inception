# 1. Project Overview

The project builds a complete web infrastructure using Docker Compose.

Each service runs inside its own container and communicates through an isolated Docker bridge network.

Architecture:

```text
Browser
    │
 HTTPS (443)
    │
    ▼
 Nginx
    │
 FastCGI
    ▼
 PHP-FPM
    │
    ▼
 WordPress
   │      │
   │      ▼
   │    Redis
   │
   ▼
 MariaDB
```

---

# 2. Project Structure

```text
srcs/

docker-compose.yml

.env

requirements/

nginx/

wordpress/

mariadb/

bonus/

redis/

ftp/

adminer/

netdata/
```

---

# 3. Docker Architecture

Each service follows the Docker philosophy:

> One service per container.

Advantages:

* Independent updates
* Easier debugging
* Better isolation
* Smaller images

---

# 4. Docker Network

All services belong to the same bridge network.

```yaml
networks:
    inception:
```

Docker DNS automatically resolves service names.

Example:

```text
wordpress

↓

mariadb

↓

172.x.x.x
```

Services never communicate using fixed IP addresses.

---

# 5. Volumes

Persistent data is stored inside Docker volumes.

MariaDB:

```text
/var/lib/mysql
```

WordPress:

```text
/var/www/html
```

Volumes guarantee data persistence even if containers are recreated.

---

# 6. Nginx

Responsibilities:

* HTTPS termination
* Reverse proxy
* Static file serving
* FastCGI forwarding

Main configuration:

* server block
* listen 443 ssl
* server_name
* location
* fastcgi_pass

Nginx never executes PHP directly.

---

# 7. SSL

The infrastructure uses a self-signed certificate generated with OpenSSL.

Generated files:

```text
nginx.crt

nginx.key
```

TLS is terminated at Nginx before forwarding requests to PHP-FPM.

---

# 8. PHP-FPM

PHP-FPM executes WordPress PHP scripts.

Communication:

```text
Nginx

↓

FastCGI

↓

PHP-FPM
```

PHP-FPM maintains a pool of worker processes instead of creating one process per request.

---

# 9. WordPress

Initialization script performs:

* Wait for MariaDB
* Download WordPress
* Generate wp-config.php
* Configure Redis
* Install WordPress
* Create administrator
* Create author
* Install Redis Cache plugin
* Enable object cache

Installation only occurs when:

```text
wp-config.php
```

does not already exist.

---

# 10. MariaDB

Initialization script:

* Initializes database
* Creates database
* Creates application user
* Grants privileges
* Starts MariaDB

MariaDB stores all persistent application data.

---

# 11. Redis

Redis is configured as the WordPress object cache.

Purpose:

* Cache frequently requested objects
* Reduce SQL queries
* Improve response time

Redis does not replace MariaDB.

MariaDB remains the source of truth.

---

# 12. FTP

vsftpd provides remote file management.

Configuration:

* Local users only
* Anonymous login disabled
* Chroot enabled
* Passive mode enabled

FTP user joins the:

```text
www-data
```

group so it can modify WordPress files while preserving ownership.

---

# 13. Adminer

Adminer is a lightweight PHP database management tool.

Used for:

* Browsing tables
* Executing SQL
* Managing users

---

# 14. Netdata

Netdata provides real-time monitoring.

Mounted resources:

```text
/proc

/sys

docker.sock
```

Allows monitoring of:

* CPU
* Memory
* Network
* Docker containers

---

# 15. Startup Order

Although Docker Compose creates containers in dependency order, service readiness is not guaranteed.

WordPress waits for MariaDB by repeatedly executing:

```text
mysqladmin ping
```

until the database accepts connections.

---

# 16. Request Lifecycle

```text
Browser

↓

HTTPS

↓

Nginx

↓

FastCGI

↓

PHP-FPM

↓

WordPress

↓

Redis

↓

MISS

↓

MariaDB

↓

WordPress

↓

HTML

↓

Nginx

↓

Browser
```

---

# 17. Security Decisions

* HTTPS only
* Self-signed TLS certificate
* Dedicated database user
* Anonymous FTP disabled
* Chroot enabled
* Containers isolated by namespaces
* Persistent data isolated using Docker volumes

---

# 18. Design Choices

## Virtual Machine vs Docker

The project uses Docker because containers share the host kernel while remaining isolated, making them lighter and faster than virtual machines.

## Secrets vs Environment Variables

Environment variables are used because this project does not require Docker Swarm. Sensitive values are centralized inside the `.env` file.

## Docker Network vs Host Network

A bridge network isolates services while providing automatic DNS resolution between containers.

## Docker Volume vs Bind Mount

Named volumes are used for persistent application data because Docker manages their lifecycle independently from the host filesystem.

---

# 19. Technologies

* Docker
* Docker Compose
* Debian
* Nginx
* PHP-FPM
* WordPress
* MariaDB
* Redis
* vsftpd
* Adminer
* Netdata
* OpenSSL
