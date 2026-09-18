# Docker Networking and Linux Networking

This directory contains networking command practice and a Docker bind-mount example.

## Contents

| Path | Description |
| --- | --- |
| [`networking-practice.md`](networking-practice.md) | Outputs and explanations for `ip`, `ping`, DNS, sockets, `curl`, and host commands |
| [`bind-mount-site/index.html`](bind-mount-site/index.html) | Website content mounted into an Nginx container |

## Docker Networking Exercises

The complete Docker networking evidence is available in the repository root [`README.md`](../README.md). It covers:

- User-defined bridge networks and container-to-container connectivity
- Host networking with Apache
- A read-only bind mount served by Nginx
- Overlay networks for multi-host Docker Swarm deployments

Example bind mount command from the repository root:

```sh
docker run -d --name homework-bind-nginx -p 18088:80 \
  -v "$PWD/Networking/bind-mount-site:/usr/share/nginx/html:ro" \
  nginx:1.27-alpine
```

## Linux Networking Topics

The practice file records examples for interfaces and routes (`ip addr`, `ip link`, `ip route`), neighbor discovery, connectivity testing, DNS lookup, listening sockets, HTTP headers, host identity, and NetworkManager status.