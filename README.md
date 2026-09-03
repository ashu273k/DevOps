# DevOps Homework

## Docker Networking and Volumes

Completed evidence for the Docker networking and volume exercises is below. The commands were run from this repository on 2026-09-03.

### 1. Container Networking

Created three networks:

```sh
docker network create homework-frontend
docker network create homework-backend
docker network create homework-database
```

Created three containers: Nginx frontend, Alpine backend, and MySQL database. The backend was attached to both `homework-frontend` and `homework-backend`; MySQL was attached to `homework-backend` and `homework-database`.

Network membership output:

```text
homework-frontend: homework-backend homework-frontend
homework-backend: homework-backend homework-mysql
homework-database: homework-mysql
```

Connectivity output:

```text
Backend reachable
mysql port reachable
```

The first result confirms frontend-to-backend DNS and HTTP connectivity. The second confirms backend-to-MySQL TCP connectivity on port `3306`.

### 2. Host Network

Pulled and ran Apache with host networking:

```sh
docker pull httpd:2.4-alpine
docker run -d --name homework-apache --network host httpd:2.4-alpine
curl -fsSI http://localhost:80 | head -n 1
docker inspect homework-apache --format 'network={{.HostConfig.NetworkMode}}'
```

Output:

```text
HTTP/1.1 200 OK
network=host
```

The Apache website is available directly at http://localhost:80.

### 3. Bind Mount

Created `Networking/bind-mount-site/index.html` and mounted it into Nginx:

```sh
docker run -d --name homework-bind-nginx -p 18088:80 \
  -v "$PWD/Networking/bind-mount-site:/usr/share/nginx/html:ro" \
  nginx:1.27-alpine
curl -fsS http://localhost:18088
```

After changing the host file, the running container returned this without being restarted:

```html
<h1>Hello students - updated without restarting</h1>
```

Mount confirmation:

```text
/home/x002/Desktop/DevOps/Networking/bind-mount-site -> /usr/share/nginx/html (ro)
```

### 4. Overlay Network Research

An overlay network is a Docker network whose virtual connectivity can span multiple Docker hosts. In Docker Swarm, a manager creates it with the `overlay` driver and services attach to it. Docker uses the Swarm control plane to distribute network information, while encapsulation allows containers on different hosts to communicate as though they share one logical network.

Typical command on a Swarm manager:

```sh
docker swarm init
docker network create --driver overlay --attachable homework-overlay
```

Use cases include multi-host service discovery, distributed web/application/database services, and isolating traffic between stacks. Overlay networks require Swarm or another orchestrator that manages multiple Docker hosts; ordinary bridge networks are local to one Docker host. `--attachable` permits standalone containers to join the overlay. Encryption can be enabled for network traffic with the overlay network's encrypted option when the deployment requires it.

### Cleanup

```sh
docker rm -f homework-frontend homework-backend homework-mysql homework-apache homework-bind-nginx
docker network rm homework-frontend homework-backend homework-database
```
