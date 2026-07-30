*This project has been created as part of the 42 curriculum by hrami.*

# Inception

## Table of Contents

- Description
- Project Architecture
- Docker Concepts
- Instructions
- Services
- Design Choices
- Comparisons
- Resources

---

# Description

## What is Inception?

Inception is a system administration project whose goal is to build a complete web infrastructure using Docker.

The project consists of multiple isolated containers communicating through a dedicated Docker network while sharing persistent data using Docker volumes.

The infrastructure includes:

- Nginx
- WordPress
- MariaDB
- Redis
- FTP
- Adminer
- Static Website
- Netdata

Each service runs in its own container and is built from a custom Dockerfile based on Debian Bullseye.

---

# Project Architecture

```
                   Browser
                      │
                 HTTPS (443)
                      │
                  Nginx
          ┌───────────┴───────────┐
          │                       │
      WordPress               Adminer
          │                       │
          └───────────┬───────────┘
                      │
                  MariaDB
                      │
                   Volume

         Redis
         FTP
         Static Website
         Netdata
```

---

# Docker Concepts

## Docker

Docker is a platform used to package applications and their dependencies inside isolated containers.

## Docker Image

A read-only template used to create containers.

## Docker Container

A running instance of a Docker image.

## Dockerfile

A text file containing instructions used to build a Docker image.

## Docker Compose

A tool used to define and manage multi-container applications using a single YAML file.

---

# Instructions

## Clone

```bash
git clone <repository>
cd inception
```

## Configure

Edit

```text
srcs/.env
```

## Build

```bash
make
```

## Stop

```bash
make clean
```

## Remove everything

```bash
make fclean
```

---

# Services

## Nginx

Reverse proxy responsible for serving HTTPS traffic.

## WordPress

PHP application running through PHP-FPM.

## MariaDB

Database server storing WordPress data.

## Redis

WordPress object cache.

## FTP

Allows file transfer to the WordPress volume.

## Adminer

Web interface for MariaDB administration.

## Static Website

Simple static website served by Nginx.

## Netdata

Real-time monitoring dashboard.

---

# Design Choices

- Every service runs inside its own Docker container.
- Every image is built from Debian Bullseye.
- Services communicate using a custom Docker bridge network.
- Persistent data is stored inside Docker named volumes.
- Secrets are stored in Docker Secrets whenever possible.
- HTTPS is terminated by Nginx.

---

# Comparisons

## Virtual Machines vs Docker

| Virtual Machine | Docker |
|-----------------|--------|
| Includes a complete Guest OS | Shares the host kernel |
| Heavy | Lightweight |
| Slower startup | Starts in seconds |
| Large storage usage | Small image size |
| Full hardware virtualization | OS-level virtualization |

---

## Secrets vs Environment Variables

### Environment Variables

- Visible inside the container environment.
- Convenient for non-sensitive configuration.
- Less secure for passwords.

### Docker Secrets

- Stored securely by Docker.
- Exposed as temporary files.
- Recommended for passwords and private data.

---

## Docker Network vs Host Network

### Docker Bridge Network

- Containers communicate through Docker DNS.
- Containers are isolated from the host.
- Recommended for multi-container applications.

### Host Network

- Shares the host networking stack.
- No network isolation.
- Mainly used for performance or debugging.

---

## Docker Volumes vs Bind Mounts

### Docker Volumes

- Managed by Docker.
- Portable.
- Recommended for databases.
- Independent from host directory layout.

### Bind Mounts

- Maps a host directory directly.
- Useful during development.
- Changes on the host immediately affect the container.

---

# Resources

## Docker

- https://docs.docker.com/
- https://docs.docker.com/compose/

## Nginx

- https://nginx.org/en/docs/

## MariaDB

- https://mariadb.com/kb/

## PHP

- https://www.php.net/docs.php

## WordPress

- https://developer.wordpress.org/

## Redis

- https://redis.io/docs/

---

# AI Usage

AI was used as a learning and documentation assistant.

It was used for:

- Understanding Docker networking.
- Understanding Linux namespaces.
- Explaining Docker internals.
- Improving documentation.
- Reviewing Dockerfiles and Docker Compose configuration.
- Debugging configuration issues.

All implementation decisions, configuration files, and source code were written, tested, and validated manually.