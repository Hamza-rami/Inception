## 1. Introduction

This document explains how to build, start, stop, and use the Inception infrastructure.

The project deploys a complete WordPress website using Docker Compose with the following services:

* Nginx
* WordPress
* MariaDB

Bonus services:

* Redis
* FTP (vsftpd)
* Adminer
* Netdata

---

# 2. Requirements

Before running the project, make sure you have:

* Docker Engine
* Docker Compose
* GNU Make

Verify:

```bash
docker --version
docker compose version
make --version
```

---

# 3. Build the Project

Build every Docker image:

```bash
make
```

or

```bash
docker compose build
```

---

# 4. Start the Infrastructure

Launch every service:

```bash
make up
```

or

```bash
docker compose up -d
```

---

# 5. Stop the Infrastructure

Stop containers:

```bash
make down
```

or

```bash
docker compose down
```

---

# 6. Remove Everything

Stop containers, remove networks, volumes and images:

```bash
make fclean
```

or

```bash
docker compose down -v
docker system prune -af
```

---

# 7. Access the Website

Open your browser:

```
https://<DOMAIN_NAME>
```

Example:

```
https://hrami.42.fr
```

Because a self-signed certificate is used, the browser will display a security warning.

Accept the warning to continue.

---

# 8. WordPress Administration

Administration panel:

```
https://<DOMAIN_NAME>/wp-admin
```

Login using the administrator credentials defined in the environment variables.

---

# 9. Bonus Services

## Redis

Redis is automatically configured and enabled as the WordPress object cache.

No manual configuration is required.

---

## FTP

FTP allows remote management of WordPress files.

Connection:

* Host: `<DOMAIN_NAME>`
* Port: `21`
* Username: `FTP_USER`
* Password: `FTP_PASSWORD`

Passive ports:

```
30000-30009
```

---

## Adminer

Database management interface:

```
https://<DOMAIN_NAME>/adminer
```

Use the MariaDB credentials defined in the environment variables.

---

## Netdata

Monitoring dashboard:

```
https://<DOMAIN_NAME>/netdata
```

Displays:

* CPU
* Memory
* Network
* Docker Containers

---

# 10. Useful Commands

View running containers:

```bash
docker ps
```

View logs:

```bash
docker compose logs
```

Logs for one service:

```bash
docker compose logs nginx
docker compose logs wordpress
docker compose logs mariadb
```

Open a shell inside a container:

```bash
docker exec -it wordpress bash
```

---

# 11. Troubleshooting

### Browser shows SSL warning

Expected behavior.

The project uses a self-signed certificate.

---

### WordPress cannot connect to MariaDB

Verify:

```bash
docker compose ps
```

Ensure the MariaDB container is running.

---

### FTP cannot connect

Verify:

* Port 21 is exposed.
* Passive ports (30000-30009) are exposed.
* Correct FTP credentials are used.

---

### Changes disappear after restarting

Verify Docker volumes:

```bash
docker volume ls
```

MariaDB should always use a persistent volume.

---

# 12. Architecture Overview

```
Browser
      │
      │ HTTPS
      ▼
Nginx
      │
      │ FastCGI
      ▼
PHP-FPM
      │
      ▼
WordPress
      │
      ├────────► Redis
      │
      └────────► MariaDB
```
